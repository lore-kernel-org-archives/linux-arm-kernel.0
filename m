From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 18 Sep 2012 09:49:39 +0800
Subject: [PATCH 26/34] media: mx2_camera: remove dead code in
 mx2_camera_add_device
In-Reply-To: <Pine.LNX.4.64.1209171017460.1689@axis700.grange>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <1347860103-4141-27-git-send-email-shawn.guo@linaro.org>
 <Pine.LNX.4.64.1209171017460.1689@axis700.grange>
Message-ID: <20120918014936.GG1338@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2012 at 10:18:42AM +0200, Guennadi Liakhovetski wrote:
> Hi Shawn
> 
> Thanks for the clean up. Would you like these patches to go via a single 
> tree, presumably, arm-soc? In this case
> 
Yes, to save the cross-tree dependency, I would like to have the series
go via arm-soc tree as a whole.

> On Mon, 17 Sep 2012, Shawn Guo wrote:
> 
> > This is a piece of code becoming dead since commit 2c9ba37 ([media]
> > V4L: mx2_camera: remove unsupported i.MX27 DMA mode, make EMMA
> > mandatory).  It should have been removed together with the commit.
> > Remove it now.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> > Cc: linux-media at vger.kernel.org
> 
> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
Thanks, Guennadi.

-- 
Regards,
Shawn
