From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 30 Mar 2012 16:14:46 +0800
Subject: [PATCH] ARM: dts: imx6q: add anatop regulators
In-Reply-To: <4F756A2D.9020500@linaro.org>
References: <1332214139-6833-1-git-send-email-paul.liu@linaro.org>
 <20120322074520.GD2213@S2101-09.ap.freescale.net>
 <4F756A2D.9020500@linaro.org>
Message-ID: <20120330081444.GE3254@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 30, 2012 at 04:09:17PM +0800, Ying-Chun Liu (PaulLiu) wrote:
> (2012?03?22? 15:45), Shawn Guo wrote:
> >> +				};
> >> +
> >> +				regulator-1p1 at 110 {
> >> +					compatible = "fsl,anatop-regulator";
> >> +					regulator-name = "vdd1p1";
> >> +					regulator-min-microvolt = <800000>;
> >> +					regulator-max-microvolt = <1400000>;
> >> +					regulator-always-on;
> >> +					reg = <0x110>;
> >> +					anatop-vol-bit-shift = <8>;
> >> +					anatop-vol-bit-width = <5>;
> >> +					anatop-min-bit-val = <4>;
> >> +					anatop-min-voltage = <800000>;
> >> +					anatop-max-voltage = <1400000>;
> > 
> > 1.375V
> 
> Hi Shawn,
> 
> Sorry, why it is not 1.4V?
> 
> LDO 1p1 should be from range 0.8V to 1.4V on section 53.3.1

Hmm, I do not see 1.4V in register description (PMU_REG_1P1).

-- 
Regards,
Shawn
