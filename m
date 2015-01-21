From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 21 Jan 2015 15:26:41 +0000
Subject: [STLinux Kernel] [PATCH 1/1] i2c: i2c-st: Rename clock reference
 to something that exists
In-Reply-To: <53FF3D55.40006@st.com>
References: <1409234523-20240-1-git-send-email-lee.jones@linaro.org>
 <53FF3D55.40006@st.com>
Message-ID: <20150121152641.GE22024@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Aug 2014, Maxime Coquelin wrote:
> On 08/28/2014 04:02 PM, Lee Jones wrote:
> >CLK_S_ICN_REG_0 hasn't existed for a while now.  This was renamed
> >over a few commits, then finally removed in commit 5aa02b9 (ARM:
> >STi: DT: STiH415: Remove unused CLK_S_ICN_REG_0 fixed clock).
> >
> >Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Maybe it will be part of my next pull-requests, but in case it is
> not, you can add my:
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Still nothing from the big man.

Can you just take this please Maxime?

> >---
> >  Documentation/devicetree/bindings/i2c/i2c-st.txt | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/Documentation/devicetree/bindings/i2c/i2c-st.txt b/Documentation/devicetree/bindings/i2c/i2c-st.txt
> >index 437e0db..4c26fda 100644
> >--- a/Documentation/devicetree/bindings/i2c/i2c-st.txt
> >+++ b/Documentation/devicetree/bindings/i2c/i2c-st.txt
> >@@ -31,7 +31,7 @@ i2c0: i2c at fed40000 {
> >  	compatible	= "st,comms-ssc4-i2c";
> >  	reg		= <0xfed40000 0x110>;
> >  	interrupts	=  <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
> >-	clocks		= <&CLK_S_ICN_REG_0>;
> >+	clocks		= <&clk_s_a0_ls CLK_ICN_REG>;
> >  	clock-names	= "ssc";
> >  	clock-frequency = <400000>;
> >  	pinctrl-names	= "default";
> >

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
