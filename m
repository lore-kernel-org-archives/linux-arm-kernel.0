From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Feb 2014 00:51:51 -0800
Subject: [GIT PULL v2] ARM: imx: device tree changes for 3.15, take 1
In-Reply-To: <20140209134849.GB22132@S2101-09.ap.freescale.net>
References: <20140209134849.GB22132@S2101-09.ap.freescale.net>
Message-ID: <20140220085151.GK19089@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 09, 2014 at 09:48:54PM +0800, Shawn Guo wrote:
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-dt-3.15
> 
> for you to fetch changes up to ee97d154f0a81f87f0f88c99a3963da2ab5ad787:
> 
>   ARM: dts: imx28-m28cu3: Remove 'reset-active-high' (2014-02-09 21:33:52 +0800)
> 
> ----------------------------------------------------------------
> i.MX device tree changes for 3.15:
>  - New SoC device tree support for imx35 and imx50
>  - A good number of new board support: imx25-eukrea, imx28-duckbill,
>    imx28-eukrea, Eukrea cpuimx35, imx50-evk, imx51-eukrea, imx53-voipac,
>    MCIMX53-START-R and Ka-Ro TX53.
>  - Quite some updates and tweaking on imx27 phycore and apf27dev boards
>  - Add pinfunc headers for imx25, imx27 and imx50
>  - Make pinctrl nodes board specific to avoid floating board specific
>    device tree blob with so many unused pinctrl data
>  - Use generic node name for fixed regulator
>  - Use clock defines in imx5 DTS files
>  - Use macros for interrupt and gpio flags
>  - A plenty of random updates on various SoC and board device tree
>    sources, adding pinctrl settings, device nodes, properties, aliases.

Merged, thanks!


-Olof
