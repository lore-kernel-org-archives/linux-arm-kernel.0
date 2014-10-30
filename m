From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Thu, 30 Oct 2014 09:12:14 +0200
Subject: [PATCH 1/2 v3] SPI: spi-pxa2xx: Add helpers for regiseters'
 accessing
In-Reply-To: <4656BEB6164FC34F8171C6538F1A595B2E9A92B3@SHSMSX101.ccr.corp.intel.com>
References: <1412783423-9408-1-git-send-email-alvin.chen@intel.com>
 <1412783423-9408-2-git-send-email-alvin.chen@intel.com>
 <4656BEB6164FC34F8171C6538F1A595B2E9A90E6@SHSMSX101.ccr.corp.intel.com>
 <5450CF36.7060105@nexus-software.ie>
 <4656BEB6164FC34F8171C6538F1A595B2E9A92B3@SHSMSX101.ccr.corp.intel.com>
Message-ID: <1414653134.2396.67.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-10-30 at 01:02 +0000, Chen, Alvin wrote:
> > >
> > 
> > Hi Alvin, Weike.
> > 
> > I'm not clear if these patches apply to the current tip-of-tree.
> > 
> > I thought the action required here, was for a resend of patches to ensure they
> > applied to tip-of-tree ?
> > 
> As I said before, it is based on the slave-dma tree (git.infraded.org) for-linus branch, which will be reapplied on top of v3.19-rc1. 
> 
> That is to say these patches will be applied to slave-dma tree for-linus branch, and then the slave-dma tree for-linus branch will be applied to v3.19.
> Andy, am I right?

All of those patches are in v3.18-rc1, so you may rebase on top of
3.18-rcX safely I guess.


-- 
Andy Shevchenko <andriy.shevchenko@intel.com>
Intel Finland Oy
