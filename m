From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Jan 2012 14:50:32 +0000
Subject: [RFC PATCH 1/5] arm:omap1/2/3/4:Convert 32k-Sync clocksource
 driver to platform_driver
In-Reply-To: <4F16DB10.8060806@arm.com>
References: <1326886086-27313-1-git-send-email-hvaibhav@ti.com>
 <1326886086-27313-2-git-send-email-hvaibhav@ti.com>
 <20120118115952.GM16726@n2100.arm.linux.org.uk>
 <79CD15C6BA57404B839C016229A409A8317A9AA2@DBDE01.ent.ti.com>
 <20120118141147.GN16726@n2100.arm.linux.org.uk> <4F16D66F.2000602@arm.com>
 <79CD15C6BA57404B839C016229A409A8317A9C39@DBDE01.ent.ti.com>
 <4F16DB10.8060806@arm.com>
Message-ID: <20120118145032.GO16726@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 02:45:36PM +0000, Marc Zyngier wrote:
> Can't you instead use the ARM sched_clock framework?

OMAP does, and has done for quite some time.  The problem is these
patches are against an old kernel.
