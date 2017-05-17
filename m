From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 May 2017 15:23:22 +0100
Subject: [patch V2 03/17] arm64: Adjust system_state check
In-Reply-To: <20170516184735.112589728@linutronix.de>
References: <20170516184231.564888231@linutronix.de>
 <20170516184735.112589728@linutronix.de>
Message-ID: <20170517142322.ml6nozzuajgz6t3z@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 16, 2017 at 08:42:34PM +0200, Thomas Gleixner wrote:
> To enable smp_processor_id() and might_sleep() debug checks earlier, it's
> required to add system states between SYSTEM_BOOTING and SYSTEM_RUNNING.
> 
> Adjust the system_state check in smp_send_stop() to handle the extra states.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel at lists.infradead.org

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
