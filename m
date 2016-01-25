From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 25 Jan 2016 10:35:02 +0200
Subject: [PATCH 03/15] dmaengine: dw: rename masters to reflect actual
 topology
In-Reply-To: <20160124223629.GI6588@sirena.org.uk>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-4-git-send-email-mans@mansr.com>
 <20160124223629.GI6588@sirena.org.uk>
Message-ID: <1453710902.2521.203.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2016-01-24 at 22:36 +0000, Mark Brown wrote:
> On Sun, Jan 24, 2016 at 07:21:50PM +0000, Mans Rullgard wrote:
> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > The source and destination masters are reflecting buses or their
> > layers to
> > where the different devices can be connected. The patch changes the
> > master
> > names to reflect which one is related to which independently on the
> > transfer
> > direction.
> 
> This is patch 3 of a series but I don't have anything else in the
> series.??What is going on with the rest of the series - what are the
> dependencies and so on?

Mark, sorry about that, but in this particular case you may consider
this patch is a standalone one. You are in the Cc list due to SPI
driver small change. This change isn't modifying functionality of the
driver.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
