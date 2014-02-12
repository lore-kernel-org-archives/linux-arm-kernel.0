From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 13 Feb 2014 00:22:57 +0100
Subject: [PATCH 1/2] bus: mvebu-mbus: Fix incorrect size for PCI aperture
 resources
In-Reply-To: <1392245828-23244-1-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1392245828-23244-1-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <1701545.GmtElNcB8L@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 February 2014 15:57:07 Jason Gunthorpe wrote:
> reg[0] is the DT base, reg[1] is the DT length in bytes,
> struct resource.end is the inclusive end address, so a -1 is
> required.
> 
> Tested on kirkwood.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>
