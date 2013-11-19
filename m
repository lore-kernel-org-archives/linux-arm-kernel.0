From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 19 Nov 2013 02:50 +0100
Subject: [PATCH 2/7] ARM: shmobile: Use interrupt macros in SoC DT files
In-Reply-To: <20131119013852.GE17628@verge.net.au>
References: <1383999839-3339-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383999839-3339-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131119013852.GE17628@verge.net.au>
Message-ID: <2390430.hJVcfjsIq8@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Tuesday 19 November 2013 10:38:52 Simon Horman wrote:
> On Sat, Nov 09, 2013 at 01:23:54PM +0100, Laurent Pinchart wrote:
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  arch/arm/boot/dts/r8a73a4.dtsi | 108 ++++++++++++++++++++++++----------
> >  arch/arm/boot/dts/r8a7740.dtsi | 106 +++++++++++++++++-----------------
> >  arch/arm/boot/dts/r8a7778.dtsi |  44 +++++++-------
> >  arch/arm/boot/dts/r8a7779.dtsi |  42 +++++++-------
> >  arch/arm/boot/dts/r8a7790.dtsi |  58 ++++++++++---------
> >  arch/arm/boot/dts/r8a7791.dtsi |  49 ++++++++--------
> >  arch/arm/boot/dts/sh73a0.dtsi  | 128 +++++++++++++++++++-----------------
> >  7 files changed, 299 insertions(+), 236 deletions(-)
> 
> There was some fuzz when applying the arch/arm/boot/dts/r8a7778.dtsi hunks
> of this patch. The result that I have queued up is as follows. Please
> double-check it.

I'll resend the patch. Which branch should I base it on ?

-- 
Regards,

Laurent Pinchart
