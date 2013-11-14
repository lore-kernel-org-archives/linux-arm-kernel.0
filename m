From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 14 Nov 2013 15:46:07 +0100
Subject: [PATCH] ARM: Kconfig: Mention R-Mobile and R-Car in addition to
 SH-Mobile
In-Reply-To: <CANqRtoTXdcjoTVDShoA_071YoNznx88YgLTumdYTviLBaK76=g@mail.gmail.com>
References: <1384351179-4593-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CANqRtoTXdcjoTVDShoA_071YoNznx88YgLTumdYTviLBaK76=g@mail.gmail.com>
Message-ID: <276890521.bvcs6YPeDX@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Thursday 14 November 2013 19:07:12 Magnus Damm wrote:
> On Wed, Nov 13, 2013 at 10:59 PM, Laurent Pinchart wrote:
> > External engineers working on R-Car platforms sometimes can't find
> > upstream platform support as the combination of the SH-Mobile name and
> > using the product number proved an effective method of concealment. Make
> > sure to mention R-Mobile and R-Car in the Kconfig comments and help
> > texts.
> > 
> > Reported-by: Phil Edworthy <phil.edworthy@renesas.com>
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Thanks for your efforts on this. I think this is a good idea, but to
> make things a bit more complex I think you should know that r7s72100
> is part of the "RZ Family". Also EMEV2 is part of the "Emma" series.
> 
> May I propose "Renesas SoC" as a generic description?

What about "Renesas ARM SoC" ?

-- 
Regards,

Laurent Pinchart
