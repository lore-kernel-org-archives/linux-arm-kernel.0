From: khilman@ti.com (Kevin Hilman)
Date: Tue, 19 Apr 2011 17:01:59 -0700
Subject: arm: davinci: Use generic irq chip
In-Reply-To: <20110416211307.686087239@linutronix.de> (Thomas Gleixner's
	message of "Sat, 16 Apr 2011 21:14:08 -0000")
References: <20110416211221.853079766@linutronix.de>
	<20110416211307.686087239@linutronix.de>
Message-ID: <87zknl94eg.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Gleixner <tglx@linutronix.de> writes:

> Simple conversion which simply uses the fact that the second irq chip
> base address has offset 0x04 to the first one.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

For davinci changes:

Reviewed-and-Tested-by: Kevin Hilman <khilman@ti.com>
