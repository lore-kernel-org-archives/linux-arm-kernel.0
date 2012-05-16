From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 16 May 2012 14:14:58 +0800
Subject: [PATCH 1/2] ARM: dts: add device tree source for imx6dl
In-Reply-To: <20120515124949.546ba4fc3b624a4777e320af@freescale.com>
References: <1337084027-19401-1-git-send-email-shawn.guo@linaro.org>
 <20120515124949.546ba4fc3b624a4777e320af@freescale.com>
Message-ID: <20120516061457.GD21517@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 12:49:49PM -0500, Kim Phillips wrote:
> On Tue, 15 May 2012 20:13:47 +0800
> Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > +			snvs at 020cc000 {
> > +				reg = <0x020cc000 0x4000>;
> > +				interrupts = <0 19 0x04 0 20 0x04>;
> > +			};
> > +
> 
> this conflicts with the existing binding documented in
> Documentation/devicetree/bindings/crypto/fsl-sec4.txt.
> 
Oh, great to know that we already have a binding for it.  Thanks for the
info, Kim.  Right now, these blocks in imx6.dtsi are just placeholders
with only IO space and interrupt numbers given, and the proper
compatible and other properties will be added per the binding you point
here when we actually have them supported for imx6.

-- 
Regards,
Shawn
