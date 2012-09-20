From: mporter@ti.com (Matt Porter)
Date: Thu, 20 Sep 2012 12:05:20 -0400
Subject: [RFC PATCH 13/13] Documentation: add schedule for removing
 private EDMA API
In-Reply-To: <20120920155858.GA4583@opensource.wolfsonmicro.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
 <1348152226-13588-14-git-send-email-mporter@ti.com>
 <20120920155858.GA4583@opensource.wolfsonmicro.com>
Message-ID: <20120920160520.GD16522@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 04:58:58PM +0100, Mark Brown wrote:
> On Thu, Sep 20, 2012 at 10:43:46AM -0400, Matt Porter wrote:
> 
> >  Documentation/feature-removal-schedule.txt |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> 
> We decided at kernel summit that we'd stop bothering with this, it's
> mostly just bitrot and rarely read.  I guess the ASoC driver update
> isn't ready yet?

Ok, I'll drop this from the series.

No, I'm just getting real time now to work on the davinci-pcm dma engine
conversion and cyclic dma support for edma. That driver is somewhat of a
mess as it has some older platforms dependent on SRAM-based ping-pong
buffering and that all need to be sorted during this. It is the only
remaining blocker though for getting rid of the private API.

-Matt
