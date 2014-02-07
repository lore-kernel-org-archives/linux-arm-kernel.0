From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 7 Feb 2014 13:48:00 -0500
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <52F51922.6030502@gmail.com>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <52F51922.6030502@gmail.com>
Message-ID: <20140207184800.GG8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 06:34:26PM +0100, Sebastian Hesselbarth wrote:
> On 02/07/2014 12:42 AM, Andrew Lunn wrote:
> >Now that all the device tree support is in mach-mvebu, remove it from
> >mach-kirkwood.
> >
> >Regenerate kirkwood_defconfig, removing all DT support, and a couple
> >of other redundent options have been removed in the process.
> >
> >Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> >---
> 
> Hmm, I wonder what Ian thinks of removing this so quickly again...
> 
> Maybe let it rot for 1-2 kernel versions?

The easiest answer is to modify kirkwood_defconfig to select both
ARCH_KIRKWOOD and MACH_KIRKWOOD until such time as we have a working dts
file for _every_ board file.  Only then should we look at beginning the
deprecation process for non-DT.

thx,

Jason.
