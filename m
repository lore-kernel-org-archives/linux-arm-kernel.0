From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 11 Mar 2013 14:47:29 +0100
Subject: [PATCH] ARM: imx: fix typo "DEBUG_IMX50_IMX53_UART"
In-Reply-To: <CAOMZO5AhjKV=ja+Agr_pMg4ghB6Vux2ciBnr_M8SQuS4AQ4Bzg@mail.gmail.com>
References: <1363007760.3137.69.camel@x61.thuisdomein>
 <20130311133720.GB25910@S2101-09.ap.freescale.net>
 <CAOMZO5AhjKV=ja+Agr_pMg4ghB6Vux2ciBnr_M8SQuS4AQ4Bzg@mail.gmail.com>
Message-ID: <1363009649.3137.78.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-03-11 at 10:41 -0300, Fabio Estevam wrote:
> Please see my commit:
> 
> commit 7356420cd34e40fe27bf26555b0bf3f2849a43dd
> Author: Fabio Estevam <fabio.estevam@freescale.com>
> Date:   Tue Jan 22 10:40:55 2013 -0200
> 
>     ARM: imx: Remove mx508 support
> 
>     Only mx508 based board is mach-mx50_rdp and it has been marked as BROKEN
>     for several releases.
> 
>     mx508 currently lacks clock support.
> 
>     In case someone needs to add mx508 support back, then the
> recommended approach
>     is to use device tree.
> 
>     Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>     Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> ,it does remove the MX50 reference, so this patch is not needed.

That's not correct:
    $ git grep -n DEBUG_IMX50_IMX53_UART v3.9-rc2
    v3.9-rc2:arch/arm/Kconfig.debug:495:                                            DEBUG_IMX50_IMX53_UART || \


Paul Bolle
