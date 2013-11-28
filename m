From: horms@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 17:24:41 +0900
Subject: [PATCH] ARM: Kconfig: Mention R-Mobile and R-Car in addition to
 SH-Mobile
In-Reply-To: <276890521.bvcs6YPeDX@avalon>
References: <1384351179-4593-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CANqRtoTXdcjoTVDShoA_071YoNznx88YgLTumdYTviLBaK76=g@mail.gmail.com>
 <276890521.bvcs6YPeDX@avalon>
Message-ID: <20131128082440.GV24146@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 03:46:07PM +0100, Laurent Pinchart wrote:
> Hi Magnus,
> 
> On Thursday 14 November 2013 19:07:12 Magnus Damm wrote:
> > On Wed, Nov 13, 2013 at 10:59 PM, Laurent Pinchart wrote:
> > > External engineers working on R-Car platforms sometimes can't find
> > > upstream platform support as the combination of the SH-Mobile name and
> > > using the product number proved an effective method of concealment. Make
> > > sure to mention R-Mobile and R-Car in the Kconfig comments and help
> > > texts.
> > > 
> > > Reported-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Thanks for your efforts on this. I think this is a good idea, but to
> > make things a bit more complex I think you should know that r7s72100
> > is part of the "RZ Family". Also EMEV2 is part of the "Emma" series.
> > 
> > May I propose "Renesas SoC" as a generic description?
> 
> What about "Renesas ARM SoC" ?

Sounds good to me.
