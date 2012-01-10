From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 10 Jan 2012 23:38:39 +0800
Subject: [PATCH 6/6] dma/imx-sdma: check whether event_id0 < 32 when set
 event_mask
In-Reply-To: <20120110142939.GB2019@richard-laptop>
References: <1326178910-14044-1-git-send-email-richard.zhao@linaro.org>
 <1326178910-14044-6-git-send-email-richard.zhao@linaro.org>
 <20120110142008.GE26599@S2101-09.ap.freescale.net>
 <20120110142939.GB2019@richard-laptop>
Message-ID: <20120110153836.GA27831@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2012 at 10:29:42PM +0800, Richard Zhao wrote:
> On Tue, Jan 10, 2012 at 10:20:10PM +0800, Shawn Guo wrote:
> > On Tue, Jan 10, 2012 at 03:01:50PM +0800, Richard Zhao wrote:
> > > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > > ---
> > 
> > I think it deserves a sensible commit message explaining why the patch
> > is needed.
> If event_id0 < 32, 1 << (sdmac->event_id0 - 32) is not zero.
> 
My point is you may explain the exact problem you are seeing without
this patch and how the patch helps here.  In general, doing so would
win a warm feeling from reviewers much more easily than leaving the
commit message empty there.

-- 
Regards,
Shawn
