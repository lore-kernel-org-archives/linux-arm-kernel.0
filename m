From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 10 Jan 2014 12:05:21 -0700
Subject: [PATCH v5 2/4] ARM: mvebu: Add quirk for i2c for the OpenBlocks
 AX3-4 board
In-Reply-To: <20140110182240.GK19878@titan.lakedaemon.net>
References: <1389193589-18485-1-git-send-email-gregory.clement@free-electrons.com>
 <1389193589-18485-3-git-send-email-gregory.clement@free-electrons.com>
 <20140110182240.GK19878@titan.lakedaemon.net>
Message-ID: <20140110190521.GI18269@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 01:22:40PM -0500, Jason Cooper wrote:

> Do we create new compatible strings to indicate errata, or to indicate
> 'from this version forward there are new features'?  The former would
> indicate as Gregory has written '...-a0-i2c', the latter would warrant
> '...-b0-i2c' and disabling offloading if we don't see '...-b0-i2c'.

IMHO the compatible string should represent a specific HW/SW ABI. So
you need a unique compatible string for every variation of that ABI.

We already have a compatible string defined for the ABI that B0
presents.

Jason
