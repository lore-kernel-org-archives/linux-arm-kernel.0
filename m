From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 31 Oct 2013 00:48:47 +0100
Subject: [PATCH 07/12] mmc: sh_mmcif: Convert to clk_prepare/unprepare
In-Reply-To: <CAPDyKFoNn9g2RmGvFnmDYfiOhZHQYY33zA=Rk5DQWEBNDyhfHQ@mail.gmail.com>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2522233.ixtrcdiJKv@avalon>
 <CAPDyKFoNn9g2RmGvFnmDYfiOhZHQYY33zA=Rk5DQWEBNDyhfHQ@mail.gmail.com>
Message-ID: <14289582.5zfRMUTTcX@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uluf,

On Thursday 31 October 2013 00:27:23 Ulf Hansson wrote:
> On 31 October 2013 00:13, Laurent Pinchart wrote:
> > On Wednesday 30 October 2013 23:23:37 Guennadi Liakhovetski wrote:
> >> On Tue, 29 Oct 2013, Guennadi Liakhovetski wrote:
> >> > On Mon, 28 Oct 2013, Laurent Pinchart wrote:
> >> > > Turn clk_enable() and clk_disable() calls into clk_prepare_enable()
> >> > > and clk_disable_unprepare() to get ready for the migration to the
> >> > > common clock framework.
> >> > > 
> >> > > Cc: Chris Ball <cjb@laptop.org>
> >> > > Cc: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> >> > > Cc: linux-mmc at vger.kernel.org
> >> > > Signed-off-by: Laurent Pinchart
> >> > > <laurent.pinchart+renesas@ideasonboard.com>
> >> > 
> >> > Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> >> 
> >> Sorry, I just realised, that an identical patch
> >> 
> >> http://patches.linaro.org/21212/
> >> 
> >> has been submitted prior to this one, so, we should really take the other
> >> one.
> > 
> > I'm fine with that, as long as one of the two patches hit mainline as soon
> > as possible.
> 
> I can put together a new pull request for Chris asap, but in the end
> it will be his call to take it now or later.

That would be great. It can wait for v3.14 though, but having the patch in 
v3.13 would be nice.

-- 
Regards,

Laurent Pinchart
