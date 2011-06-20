From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Jun 2011 11:44:15 +0100
Subject: [RFC PATCH] ARM: smp: Fix the CPU hotplug race with scheduler.
In-Reply-To: <4DFF20B3.7010209@ti.com>
References: <1308561839-18407-1-git-send-email-santosh.shilimkar@ti.com>
	<20110620095053.GA2082@n2100.arm.linux.org.uk>
	<20110620101438.GD2082@n2100.arm.linux.org.uk>
	<4DFF20B3.7010209@ti.com>
Message-ID: <20110620104415.GF2082@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2011 at 03:58:03PM +0530, Santosh Shilimkar wrote:
> No it doesn't work. I still get the crash. The important point
> here is not to enable interrupts before CPU is marked
> as online and active.

What is the crash (in full please)?

Do we know what interrupt is causing it?
