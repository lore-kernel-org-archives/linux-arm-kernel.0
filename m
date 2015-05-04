From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 4 May 2015 16:34:04 +0530
Subject: [PATCH 4/5] dmaengine: hsu: Fix memory leak when stopping a
 running transfer
In-Reply-To: <20150428111708.GB16174@kroah.com>
References: <1427456155-28990-1-git-send-email-peter.ujfalusi@ti.com>
 <1427456155-28990-5-git-send-email-peter.ujfalusi@ti.com>
 <1427457718.14897.428.camel@linux.intel.com>
 <20150330173732.GK7192@intel.com>
 <20150428111708.GB16174@kroah.com>
Message-ID: <20150504110404.GH3521@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 28, 2015 at 01:17:08PM +0200, 'Greg Kroah-Hartman' wrote:
> On Mon, Mar 30, 2015 at 11:07:32PM +0530, Vinod Koul wrote:
> > On Fri, Mar 27, 2015 at 02:01:58PM +0200, Andy Shevchenko wrote:
> > > On Fri, 2015-03-27 at 13:35 +0200, Peter Ujfalusi wrote:
> > > > The vd->node is removed from the lists when the transfer started so the
> > > > vchan_get_all_descriptors() will not find it. This results memory leak.
> > > > 
> > > 
> > > Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Vinod Koul <vinod.koul@intel.com>
> > 
> > Greg,
> > 
> > Please apply this in your queue for next
> 
> Apply what?  Can someone resend this in a format I can apply it in?

Ah sorry Greg, I thought you were cced in the orignal patch as well, so..

Peter, can you resend, now that this is in my next I will apply it

-- 
~Vinod

> 
> thanks,
> 
> gregk -h

-- 
