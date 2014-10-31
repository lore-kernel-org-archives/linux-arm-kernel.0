From: alvin.chen@intel.com (Chen, Alvin)
Date: Fri, 31 Oct 2014 05:43:08 +0000
Subject: [PATCH 1/2 v3] SPI: spi-pxa2xx: Add helpers for regiseters'
 accessing
References: <1412783423-9408-1-git-send-email-alvin.chen@intel.com>
 <1412783423-9408-2-git-send-email-alvin.chen@intel.com>
 <4656BEB6164FC34F8171C6538F1A595B2E9A90E6@SHSMSX101.ccr.corp.intel.com>
 <5450CF36.7060105@nexus-software.ie>
 <4656BEB6164FC34F8171C6538F1A595B2E9A92B3@SHSMSX101.ccr.corp.intel.com>
 <1414653134.2396.67.camel@linux.intel.com>
Message-ID: <4656BEB6164FC34F8171C6538F1A595B2E9A9CB6@SHSMSX101.ccr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >
> > All of those patches are in v3.18-rc1, so you may rebase on top of
> > 3.18-rcX safely I guess.
> >
> Andy, I remember you ask me to rebase on the slave-dma tree (git.infraded.org)
> for-linus branch, and the slave-dma for-linus branch will be reapplied on top of
> v3.19-rc1.
> 
Just to confirm, these patches can be applied well on top of 3.18-rc2.

> So now I need rebase on top of 3.18-rcX, isn't it? Just to confirm.
