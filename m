From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 23 Nov 2014 16:25:11 +0800
Subject: [PATCH] ARM: dts: imx6q-tbs2910: Enable snvs-poweroff
In-Reply-To: <546E4BA6.5020606@web.de>
References: <1416380089-6317-1-git-send-email-smoch@web.de>
 <546E4BA6.5020606@web.de>
Message-ID: <20141123082510.GD11253@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 20, 2014 at 09:14:30PM +0100, Soeren Moch wrote:
> On 11/19/14 07:54, Soeren Moch wrote:
> >This patch enables snvs-poweroff for TBS2910 boards.
> >
> >Signed-off-by: Soeren Moch <smoch@web.de>
> >--
> >Cc: Shawn Guo <shawn.guo@linaro.org>
> >Cc: Sascha Hauer <kernel@pengutronix.de>
> >Cc: linux-kernel at vger.kernel.org
> >---
> >  arch/arm/boot/dts/imx6q-tbs2910.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> >diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
> >index d2a5743..7e7496c 100644
> >--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
> >+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
> >@@ -208,6 +208,10 @@
> >  	status = "okay";
> >  };
> >+&snvs_poweroff {
> >+	status = "okay";
> >+};
> >+
> >  &spdif {
> >  	pinctrl-names = "default";
> >  	pinctrl-0 = <&pinctrl_spdif>;
> Shawn,
> 
> since snvs_poweroffis applied now, can you take this patch for 3.19?

Applied for 3.19, thanks.
