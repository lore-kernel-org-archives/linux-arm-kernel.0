From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Mon, 21 Nov 2016 12:32:00 +0200
Subject: [PATCH 1/2] i2c: designware: report short transfers
In-Reply-To: <E1c7p12-0000R0-S8@rmk-PC.armlinux.org.uk>
References: <20161118193542.GO1041@n2100.armlinux.org.uk>
 <E1c7p12-0000R0-S8@rmk-PC.armlinux.org.uk>
Message-ID: <20161121103200.GG1446@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 07:40:04PM +0000, Russell King wrote:
> Rather than reporting success for a short transfer due to interrupt
> latency, report an error both to the caller, as well as to the kernel
> log.
> 
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
