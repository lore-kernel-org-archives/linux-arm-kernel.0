From: tj@kernel.org (Tejun Heo)
Date: Tue, 16 Jun 2015 16:13:41 -0400
Subject: [PATCH v5 0/2] ahci: Add generic MSI-X support for single
 interrupts to SATA PCI
In-Reply-To: <20150616132434.GO10428@rric.localhost>
References: <1433526566-21136-1-git-send-email-rric@kernel.org>
 <20150616132434.GO10428@rric.localhost>
Message-ID: <20150616201341.GD22637@mtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 03:24:34PM +0200, Robert Richter wrote:
> On 05.06.15 19:49:24, Robert Richter wrote:
> > From: Robert Richter <rrichter@cavium.com>
> > 
> > This patch set adds generic support for MSI-X interrupts to the SATA
> > PCI driver.
> > 
> > One patch does the generic change, the other add support for Cavium's
> > ThunderX host controller.
> 
> Tejun,
> 
> any comment on this?

Oops, sorry, the thread fell through the crack somehow.  I applied the
two patches to libata/for-4.2 with some comment edits on the first
patch.

Thanks!

-- 
tejun
