From: olof@lixom.net (Olof Johansson)
Date: Thu, 20 Feb 2014 00:50:31 -0800
Subject: [GIT PULL v2] ARM: imx: i.MX6 DT changes for 3.15, take 1
In-Reply-To: <20140209134701.GA22132@S2101-09.ap.freescale.net>
References: <20140209134701.GA22132@S2101-09.ap.freescale.net>
Message-ID: <20140220085031.GJ19089@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 09, 2014 at 09:47:07PM +0800, Shawn Guo wrote:
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>   Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx6-dt-3.15
> 
> for you to fetch changes up to 22030dea67461df3fefb360ed33c6e2fbd578c9e:
> 
>   ARM: dts: imx6q: Add support for Zealz GK802 (2014-02-09 21:30:04 +0800)
> 
> ----------------------------------------------------------------
> i.MX6 device tree changes for 3.15:
>  - A good number of new i.MX6 boards support: cm-fx6, dmo-edmqmx6,
>    nitrogen6x, Gateworks Ventana gw5xxx family, DFI FS700-M60 and
>    Zealz GK802
>  - Update imx6q-sabrelite device tree and add Dual Lite/Solo support
>  - Move pins that are used by particular client device out of hog group
>  - Use GPIO_6 for FEC interrupt to workaround a hardware bug (ERR006687
>    ENET: Only the ENET wake-up interrupt request can wake the system
>    from Wait mode.)
>  - Make pinctrl nodes board specific to avoid floating board specific
>    device tree blob with so many unused pinctrl data
>  - Use generic node name for fixed regulator
>  - Update OPP table for cpufreq support
>  - Random updates on various board device tree sources, adding pinctrl
>    settings, device nodes, properties, etc.

Pulled, thanks.


-Olof
