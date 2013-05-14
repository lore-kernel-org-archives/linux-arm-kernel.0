From: marex@denx.de (Marek Vasut)
Date: Tue, 14 May 2013 05:30:48 +0200
Subject: [PATCH 1/3] ARM: dts: imx28-evk: Enable touchscreen support
In-Reply-To: <20130514023142.GA16250@S2101-09.ap.freescale.net>
References: <1360337803-19858-1-git-send-email-festevam@gmail.com>
 <CAOMZO5AeJUtyRC1BoAUiFihbjKtLMC2WBjaUXW0x+RE+QHYPnA@mail.gmail.com>
 <20130514023142.GA16250@S2101-09.ap.freescale.net>
Message-ID: <201305140530.48910.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Mon, May 13, 2013 at 08:48:12AM -0300, Fabio Estevam wrote:
> > Hi Shawn,
> > 
> > On Sun, Mar 24, 2013 at 11:18 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> > > Yes, when testing on next-20130322, it seems audio playback works.  But
> > > since when the patch gets applied on my mxs/dt branch, it breaks audio
> > > there, I still can not apply it.
> > 
> > Could you please apply the touchscreen patch now?
> 
> Have you tested it against v3.10-rc1?  The issue is still there in my
> testing.

Are the block handling touchscreen (lradc) and the block handling audio 
(sgtl5000+ssi) not two completely separate blocks? How can one influence the 
other?

There is a possibility that there's some problem with broken clock bindings or 
clock structure maybe? That's the only thing that comes to mind that might cause 
it.

Best regards,
Marek Vasut
