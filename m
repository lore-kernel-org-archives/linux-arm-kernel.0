From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 14 Feb 2016 10:19:29 +0800
Subject: [PATCH v7 4/7] ARM: dts: imx: Add support for Advantech/GE Bx50v3
In-Reply-To: <56B3E578.2080209@timesys.com>
References: <1454109558-22800-1-git-send-email-akshay.bhat@timesys.com>
 <1454109558-22800-5-git-send-email-akshay.bhat@timesys.com>
 <20160203145256.GR8307@tiger> <56B3E578.2080209@timesys.com>
Message-ID: <20160214021929.GC6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 04, 2016 at 06:57:44PM -0500, Akshay Bhat wrote:
> >>+/ {
> >>+	clocks {
> >>+		#address-cells = <1>;
> >>+		#size-cells = <0>;
> >
> >These are already specified in imx6qdl.dtsi.
> >
> 
> Will fix this. Once it is removed, should I have a new line before
> the child node?
> eg:
> 
> clocks {
> 

No, this new line is not needed.

Shawn

> 	mclk: clock at 0 {
> 		compatible = "fixed-clock";
> >>+
> >>+		mclk: clock at 0 {
> >>+			compatible = "fixed-clock";
> >>+			reg = <0>;
> >>+			#clock-cells = <0>;
> >>+			clock-frequency = <22000000>;
> >>+		};
> >>+	};
