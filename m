From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 2 Mar 2011 14:23:45 +0100 (CET)
Subject: [PATCH v8 1/1] PRUSS UIO driver support
In-Reply-To: <1299065886-30099-2-git-send-email-pratheesh@ti.com>
References: <1299065886-30099-1-git-send-email-pratheesh@ti.com>
	<1299065886-30099-2-git-send-email-pratheesh@ti.com>
Message-ID: <alpine.LFD.2.00.1103021421390.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Mar 2011, Pratheesh Gangadhar wrote:

> This patch implements PRUSS (Programmable Real-time Unit Sub System)
> UIO driver which exports SOC resources associated with PRUSS like
> I/O, memories and IRQs to user space. PRUSS is dual 32-bit RISC
> processors which is efficient in performing embedded tasks that
> require manipulation of packed memory mapped data structures and
> handling system events that have tight real time constraints. This
> driver is currently supported on Texas Instruments DA850, AM18xx and
> OMAP-L138 devices.
> For example, PRUSS runs firmware for real-time critical industrial
> communication data link layer and communicates with application stack
> running in user space via shared memory and IRQs.
> 
> Signed-off-by: Pratheesh Gangadhar <pratheesh@ti.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

No further objections.

Thanks for your patience,

       tglx
