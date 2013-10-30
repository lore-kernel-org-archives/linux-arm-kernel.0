From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 31 Oct 2013 00:13:58 +0100
Subject: [PATCH 07/12] mmc: sh_mmcif: Convert to clk_prepare/unprepare
In-Reply-To: <Pine.LNX.4.64.1310302322480.25391@axis700.grange>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <Pine.LNX.4.64.1310290910160.8404@axis700.grange>
 <Pine.LNX.4.64.1310302322480.25391@axis700.grange>
Message-ID: <2522233.ixtrcdiJKv@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guennadi,

On Wednesday 30 October 2013 23:23:37 Guennadi Liakhovetski wrote:
> On Tue, 29 Oct 2013, Guennadi Liakhovetski wrote:
> > On Mon, 28 Oct 2013, Laurent Pinchart wrote:
> > > Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
> > > clk_disable_unprepare() to get ready for the migration to the common
> > > clock framework.
> > > 
> > > Cc: Chris Ball <cjb@laptop.org>
> > > Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > > Cc: linux-mmc at vger.kernel.org
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > 
> > Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> Sorry, I just realised, that an identical patch
> 
> http://patches.linaro.org/21212/
> 
> has been submitted prior to this one, so, we should really take the other
> one.

I'm fine with that, as long as one of the two patches hit mainline as soon as 
possible.

-- 
Regards,

Laurent Pinchart
