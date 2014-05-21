From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 May 2014 15:00:34 -0700
Subject: [GIT PULL] ARM: imx: device tree changes for 3.16
In-Reply-To: <20140516151258.GD10685@dragon>
References: <20140516151258.GD10685@dragon>
Message-ID: <20140521220034.GI24972@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 11:12:59PM +0800, Shawn Guo wrote:
> The following changes since commit d1db0eea852497762cab43b905b879dfcd3b8987:
> 
>   Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-3.16
> 
> for you to fetch changes up to c6f0b878f9b56a755431c74e217830f6550f62b4:
> 
>   ARM: dts: imx35-pdk: Fix memory region description (2014-05-16 23:02:13 +0800)
> 
> ----------------------------------------------------------------
> i.MX device tree changes for 3.16:
>  - New board support: imx35-pdk, imx51-digi-connectcore, imx6dl-phytec,
>    imx6dl-riotboard, and vf610-colibri.
>  - Improve device tree support for imx51-babbage and eukrea-cpuimx51 to
>    get the same level support as board files, so that we can kill the
>    board files.
>  - Quite some updates on imx27-phytec-phycore board support from
>    Alexander Shiyan
>  - Enable USB, sound and touchscreen on the eukrea imx25/35/51 boards,
>    from Denis Carikli
>  - Quite a lot of patches from Fabio Estevam, updating Freescale
>    imx25-pdk and imx27-pdk board support
>  - Correct USB device configuration for imx25/35
>  - Fixes i2c4 device node in imx6dl.dtsi regarding to compatible string
>    and clock data
>  - Enable HDMI, TVE, LVDS display support on a bunch of imx5/6 boards
>  - Update PCIe to the new binding and enable PCIe support on
>    imx6qdl-sabresd board
>  - A couple of imx6q-dmo-edmqmx6 updates from Lucas Stach, adding pfuze
>    irq gpio and SPI flash
>  - Enable CODA7541 VPU for i.MX53
>  - A series of updates on imx6qdl-phytec boards from Philipp Zabel
>  - Small cleanups and fixes on board imx28-duckbill - Michael Heimpold
>  - Add stdout-path property to i.MX boards
>  - Karo TX25 board updates from Sascha Hauer
>  - Enable pwm and sdhc devices for board vf610-twr

Pulled into next/dt.


-Olof
