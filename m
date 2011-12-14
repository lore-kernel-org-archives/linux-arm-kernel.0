From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 14 Dec 2011 13:26:00 +0800
Subject: [PATCH V3 0/4] add imx6q sabrelite board support
In-Reply-To: <1323826007-17937-1-git-send-email-richard.zhao@linaro.org>
References: <1323826007-17937-1-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111214052559.GL28768@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since V2:
 - Add rename uart lables
 - drop cpufreq patches

> Changes since V1:
>  - rename gpio labels
>  - imx6q-sabrelite.dts: remove fec_mac and bootargs
>  - add clock_frequency in cpu0 node to check max cpu frequency
>  - add item in Kconfig in alpha order
> 
> 
> [PATCH V3 1/4] dts/imx: rename gpio labels to consistent with hw
> [PATCH V3 2/4] dts/imx: rename uart labels to consistent with hw
> [PATCH V3 3/4] arm/imx6: add imx6q sabrelite board support
> [PATCH V3 4/4] arm/imx6q-sabrelite: add enet phy ksz9021rn fixup
> 
> Thanks
> Richard
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
