From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 Aug 2013 11:11:23 -0400
Subject: [PATCH v2 0/5] ARM: dove: DT PCIe support
In-Reply-To: <20130813140130.GA25111@titan.lakedaemon.net>
References: <1376396724-32048-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130813140130.GA25111@titan.lakedaemon.net>
Message-ID: <20130813151123.GB25111@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 10:01:30AM -0400, Jason Cooper wrote:
> Bjorn,
> 
> On Tue, Aug 13, 2013 at 02:25:19PM +0200, Sebastian Hesselbarth wrote:
> > This patch set adds support for the PCIe controllers found on Marvell
> > Dove SoCs. It depends on mvebu-pci patches sent by Thomas Petazzoni.
> 
> Well, when it rains, it pours.  If this series looks good to you, I'll
> go ahead and add it on top of Thomas' patches.

And I can confirm, this series definitely depends on mvebu/boards,
mvebu/mbus_dt, and mvebu/msi_mvebu (which, in turn, depends on
mvebu/msi_irq and mvebu/msi_pci).

thx,

Jason.
