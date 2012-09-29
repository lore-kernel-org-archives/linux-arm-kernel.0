From: olof@lixom.net (Olof Johansson)
Date: Sat, 29 Sep 2012 14:19:37 -0700
Subject: [PATCH] ATA: sata_mv: Fix warnings when no PCI
In-Reply-To: <1348844650-2957-1-git-send-email-andrew@lunn.ch>
References: <1348844650-2957-1-git-send-email-andrew@lunn.ch>
Message-ID: <20120929211937.GG12999@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 28, 2012 at 05:04:10PM +0200, Andrew Lunn wrote:
> Dove can be configured with PCI. We then get a number of warnings:
> 
> warning: 'msi' defined but not used
> warning: 'mv5_sht' defined but not used
> warning: 'mv_dump_pci_cfg' defined but not used.
> 
> Move around variables and add #ifdef as necassary to fix the warnings.

Hi,

This should probably go through the libata maintainer, or at least be cc:d him
so you can get an ack on it (in case there are other dependencies on ARM
changes for it).  

-Olof
