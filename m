From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 9 Sep 2014 15:00:11 -0300
Subject: [PATCH 1/3] ASoC: tegra: add tegra sgtl5000 machine driver
In-Reply-To: <f90791ebb1799a4aa62dd6b527885ddadae3c058.1410276224.git.marcel@ziswiler.com>
References: <cover.1410276224.git.marcel@ziswiler.com>
 <f90791ebb1799a4aa62dd6b527885ddadae3c058.1410276224.git.marcel@ziswiler.com>
Message-ID: <CAOMZO5BYGwHGSeHeaQxEO=BUBGbno9P29et582SDzmwmfVioZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 9, 2014 at 12:28 PM, Marcel Ziswiler <marcel@ziswiler.com> wrote:
> This binding and driver describe/support playback to headphones, and
> capture from line-in and microphone.
>
> This driver is useful for the Toradex Apalis T30 and Colibri T30 modules.
>
> Signed-off-by: Marcel Ziswiler <marcel@ziswiler.com>
> ---
>  .../bindings/sound/nvidia,tegra-audio-sgtl5000.txt |  45 +++++
>  sound/soc/tegra/Kconfig                            |  10 +
>  sound/soc/tegra/Makefile                           |   2 +
>  sound/soc/tegra/tegra_sgtl5000.c                   | 216 +++++++++++++++++++++

What about using the simple-audio-card binding instead of adding the
tegra_sgtl5000 machine driver?

An example of simple-audio-card used with sgtl5000 can be found here:

http://www.spinics.net/lists/devicetree/msg44466.html
