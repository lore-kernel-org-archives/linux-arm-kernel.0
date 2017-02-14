From: helgaas@kernel.org (Bjorn Helgaas)
Date: Tue, 14 Feb 2017 17:55:01 -0600
Subject: [PATCH 00/37] PCI: Support for configurable PCI endpoint
In-Reply-To: <5891D53E.5050409@ti.com>
References: <1484216786-17292-1-git-send-email-kishon@ti.com>
 <5891D53E.5050409@ti.com>
Message-ID: <20170214235501.GD19040@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 06:01:58PM +0530, Kishon Vijay Abraham I wrote:
> - list
> 
> Hi Bjorn,
> 
> How do you want to handle this series? I'll send one more version of the series
> including the directory restructuring in the same series. Should it be based on
> your -next?

I think if you base it on my pci/host-designware branch, it should
work pretty well.  I haven't merged that into -next yet, but I will
soon.

I'm not sure there was consensus on all the patches yet, but if you
can group the easy ones at the beginning, I should be able to at least
get quite a few out of the way.

Bjorn
