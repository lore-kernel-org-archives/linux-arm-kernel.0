From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Mon, 25 Jan 2016 16:01:41 +0200
Subject: [PATCH 03/15] dmaengine: dw: rename masters to reflect actual
 topology
In-Reply-To: <20160125122429.GN6588@sirena.org.uk>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-4-git-send-email-mans@mansr.com>
 <20160124223629.GI6588@sirena.org.uk>
 <1453710902.2521.203.camel@linux.intel.com>
 <20160125122429.GN6588@sirena.org.uk>
Message-ID: <1453730501.2521.222.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-01-25 at 12:24 +0000, Mark Brown wrote:
> On Mon, Jan 25, 2016 at 10:35:02AM +0200, Andy Shevchenko wrote:
> > On Sun, 2016-01-24 at 22:36 +0000, Mark Brown wrote:
> 
> > > This is patch 3 of a series but I don't have anything else in the
> > > series.??What is going on with the rest of the series - what are
> > > the
> > > dependencies and so on?
> 
> > Mark, sorry about that, but in this particular case you may
> > consider
> > this patch is a standalone one. You are in the Cc list due to SPI
> > driver small change. This change isn't modifying functionality of
> > the
> > driver.
> 
> And there's no dependency relationship with the rest of the series?

Yes, in this particular case. To confirm I even rebased locally the
series to be 100% sure.

The complete series can be found in
https://bitbucket.org/mansr/linux-dwc/branch/dwc-sata

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
