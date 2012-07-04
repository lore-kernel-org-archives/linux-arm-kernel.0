From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 4 Jul 2012 10:53:02 +0100
Subject: [PATCH] ARM: imx: Fix build error due to missing irqs.h include
In-Reply-To: <20120704033018.GA1862@S2100-06.ap.freescale.net>
References: <1341365144-4549-1-git-send-email-festevam@gmail.com>
 <20120704033018.GA1862@S2100-06.ap.freescale.net>
Message-ID: <20120704095302.GK16319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2012 at 11:30:22AM +0800, Shawn Guo wrote:
> Dammit.  I forgot testing imx_v4_v5_defconfig again with the last FIQ
> change.  Thanks, Fabio.

So, this begs the question - which configs have you tested this series with?
