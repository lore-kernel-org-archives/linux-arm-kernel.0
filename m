From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 9 Jan 2018 16:39:18 +0100
Subject: [PATCH v2 3/7] PCI: aardvark: set host and device to the same
 MAX payload size
In-Reply-To: <20171005173102.GR25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
 <20170928125838.11887-4-thomas.petazzoni@free-electrons.com>
 <20171005173102.GR25517@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20180109163918.5e46c1a1@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Bjorn,

On Thu, 5 Oct 2017 12:31:02 -0500, Bjorn Helgaas wrote:
> On Thu, Sep 28, 2017 at 02:58:34PM +0200, Thomas Petazzoni wrote:
> > From: Victor Gu <xigu@marvell.com>
> > 
> > Since the Aardvark does not implement a PCIe root bus,   
> 
> What exactly do you mean by "does not implement a PCIe root bus"?  I
> assume there is still a hierarchy of PCI buses, and I assume the
> hierarchy has a top-most ("root") bus.
> 
> Maybe there's no Root Port?  There are other systems that don't have
> Root Ports, and we've made changes to accommodate that, e.g.,
> 
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=1b8a6079015f

I'm trying to get back (finally) to this topic. Unfortunately, your
branch has been rebased, and this commit no longer exists. Do you have
an updated pointer about what you suggest to use for systems that don't
have Root Ports ?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
