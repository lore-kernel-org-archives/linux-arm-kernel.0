From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 4 Sep 2013 21:19:49 +0800
Subject: [PATCH v2 0/4] *** ARM: imx6sl: add FEC support for imx6sl evk
 platform ***
In-Reply-To: <1378182385-9205-1-git-send-email-B38611@freescale.com>
References: <1378182385-9205-1-git-send-email-B38611@freescale.com>
Message-ID: <20130904131947.GA16797@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 03, 2013 at 12:26:21PM +0800, Fugang Duan wrote:
> Changelog:
> 
> V2:
>  * Split iomuxc-gpr and fec phy gpio reset dts patch
>  * Sort included header file
> 
> v1:
>  * Add iomuxc-gpr device node
>  * Add imx6sl evk fec phy gpio reset
>  * Add imx6sl iomuxc-gpr fec gpr field define
>  * Add fec init function to select clock source.
> 
> Fugang Duan (4):
>   ARM: dts: add iomuxc-gpr device node for imx6sl
>   ARM: dts: add fec phy reset for imx6sl evk board
>   ARM: imx6sl: add imx6sl iomux-gpr field define
>   ARM: imx6sl: config iomux-gpr1 to select clock for fec

Applied all, thanks.
