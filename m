From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 6 Oct 2012 10:16:10 -0300
Subject: [PATCH] ARM: dts: imx6q-sabreauto: Add basic support
In-Reply-To: <20121006130344.GE20231@S2101-09.ap.freescale.net>
References: <1348615018-14465-1-git-send-email-festevam@gmail.com>
 <20121006130344.GE20231@S2101-09.ap.freescale.net>
Message-ID: <CAOMZO5Dk2YKS=RTMKe5jejvtPqw1rNFt2G0EPvYo3uM2rFZYEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 6, 2012 at 10:03 AM, Shawn Guo <shawn.guo@linaro.org> wrote:

>>  Documentation/devicetree/bindings/arm/fsl.txt |    4 ++
>>  arch/arm/boot/dts/imx6q-sabreauto.dts         |   65 +++++++++++++++++++++++++
>
> Add imx6q-sabreauto.dtb into arch/arm/boot/dts/Makefile.

Ok, looking at arch/arm/boot/dts/Makefile I see that
imx6q-sabrelite.dtb, for example appears
under dtb-$(CONFIG_ARCH_MXC) and dtb-$(CONFIG_SOC_IMX6Q)

Would you like a patch to remove this duplicate entry?

Should we use only CONFIG_SOC?

Regards,

Fabio Estevam
