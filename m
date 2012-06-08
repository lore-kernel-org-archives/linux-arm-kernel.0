From: marex@denx.de (Marek Vasut)
Date: Fri, 8 Jun 2012 21:03:09 +0200
Subject: [PATCH] MXS: Add DENX M28 dts file
In-Reply-To: <20120606081726.GG2667@S2101-09.ap.freescale.net>
References: <1338084735-12083-1-git-send-email-marex@denx.de>
 <20120606081726.GG2667@S2101-09.ap.freescale.net>
Message-ID: <201206082103.09612.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Sun, May 27, 2012 at 04:12:15AM +0200, Marek Vasut wrote:
> > Missing:
> > AUART
> > LCDIF

[...]

> > +				gpmi_pins_ctrl_m28: gpmi1 at 0 {
> > +					reg = <0>;
> > +					fsl,pinmux-ids = <0x180 0x0190
> > +							  0x01a0 0x01b0>;
> > +					fsl,drive-strength = <3>;
> > +					fsl,voltage = <0>;
> > +					fsl,pull-up = <1>;
> > +				};
> 
> I just applied Huang's gpmi changes below.  Can you please rebase the
> the patch on top of it?  If you have the same pin setup as imx28-evk,
> we can save above data completely.
> 
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/169351

Well, GPMI NAND doens't work for me (AGAIN). Screw this, I'm not debuging it for 
the third damn time only to be told to rebase it again and that all I did was 
for naught. Sorry

Best regards,
Marek Vasut
