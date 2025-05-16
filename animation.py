import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.animation as animation  # you already have this

def create_temperature_animation_gif(csv_path, output_gif, sep=','):
    df = pd.read_csv(csv_path, sep=sep,
                     names=['row','col','temperature','time'],
                     header=None)

    timesteps = sorted(df['time'].unique())
    max_row = int(df['row'].max())
    max_col = int(df['col'].max())

    fig, ax = plt.subplots(figsize=(6,5))
    im = ax.imshow(
        np.zeros((max_row, max_col)),
        origin='lower',
        interpolation='nearest',
        aspect='equal',
        cmap='jet',
        vmin=0, vmax=100
    )
    fig.colorbar(im, ax=ax, label='Temperature (°C)')
    ax.set_xlabel('Column')
    ax.set_ylabel('Row')

    def animate(t):
        df_t = df[df['time'] == t]
        grid = (df_t
                .pivot(index='row', columns='col', values='temperature')
                .sort_index()
                .sort_index(axis=1))
        im.set_data(grid.values)
        ax.set_title(f'Time = {t}')
        return (im,)

    ani = animation.FuncAnimation(
        fig, animate, frames=timesteps, blit=True, interval=1000
    )

    # Use PillowWriter to save as GIF
    writer = animation.PillowWriter(fps=1)
    ani.save(output_gif, writer=writer)
    plt.close(fig)

# Example call:
if __name__ == "__main__":
    create_temperature_animation_gif(
        csv_path='./output/output.csv',
        output_gif='temperature_animation.gif',
        sep=','
    )
