From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Wed, 27 Jan 2016 14:26:23 +0200
Subject: [PATCH 07/15] dmaengine: dw: revisit data_width property
In-Reply-To: <20160126210726.GA4096@rob-hp-laptop>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-8-git-send-email-mans@mansr.com>
 <20160126210726.GA4096@rob-hp-laptop>
Message-ID: <1453897583.2521.246.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-01-26 at 15:07 -0600, Rob Herring wrote:
> On Sun, Jan 24, 2016 at 07:21:54PM +0000, Mans Rullgard wrote:

> > This patch changes the DT binding, so it should probably be amended
> > for
> > compatibility with old device trees.??I've included it as is since
> > I think
> > the change as such is good.
> 
> Just because you update the dts files, it doesn't make the change
> okay.?
> I'm fine with the DT change, but the driver would have to support
> both?
> old and new property names.

We will fix this.

>  Doesn't really seem worth doing to me.

The big issue with DT, you know, is hanging around names. This moves
name to be de facto standard for similar in the other drivers.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
