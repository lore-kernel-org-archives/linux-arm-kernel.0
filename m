From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Mar 2016 22:35:22 +0100
Subject: [PATCH 0/5] Modularize PCI_DW related drivers.
In-Reply-To: <56D40F7F.5060204@ti.com>
References: <1454889644-27830-1-git-send-email-paul.gortmaker@windriver.com>
 <2837386.VTD89bjPJz@wuerfel> <56D40F7F.5060204@ti.com>
Message-ID: <2163039.5ZupTHB3qf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 February 2016 14:59:35 Kishon Vijay Abraham I wrote:
> > }
> > 
> > You just need to pass the same resource in here htat you pass into
> > pci_remap_iospace().
> 
> I still seem to get the abort in ioremap_page_range().
> 
> Here's the patch I used [3] and here's the kernel log [4].
> 
> [3] -> http://pastebin.ubuntu.com/15241614/
> [4] -> http://pastebin.ubuntu.com/15241637/
> 
> 

Sorry, I'm out of ideas here. The patch looks right to me, but the problem
looks unchanged.

	Arnd
