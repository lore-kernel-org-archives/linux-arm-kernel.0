From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 12 Dec 2012 18:01:21 +0000
Subject: [RFC PATCH 1/3] ARM: mm: Add discontiguous memory support.
In-Reply-To: <1355334049-10247-2-git-send-email-steve.capper@arm.com>
References: <1355334049-10247-1-git-send-email-steve.capper@arm.com>
 <1355334049-10247-2-git-send-email-steve.capper@arm.com>
Message-ID: <20121212180121.GB14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 12, 2012 at 05:40:47PM +0000, Steve Capper wrote:
> This patch adds support for discontiguous memory, with a view to
> each discontiguous block being assigned to a NUMA node (in a future
> patch).
> 
> Discontiguous memory should only be used to back NUMA on systems
> where sparse memory is not available.

Err, we had this, and then we ripped it all out.  Do we have any NUMA ARM
systems?  I don't think we do.
