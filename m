From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 Mar 2011 10:11:36 +0100
Subject: [PATCH v10 1/1] PRUSS UIO driver support
In-Reply-To: <1299213772-21931-2-git-send-email-pratheesh@ti.com>
References: <1299213772-21931-1-git-send-email-pratheesh@ti.com>
	<1299213772-21931-2-git-send-email-pratheesh@ti.com>
Message-ID: <201103041011.36932.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 March 2011 05:42:52 Pratheesh Gangadhar wrote:
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
 
Looks good

> Signed-off-by: Pratheesh Gangadhar <pratheesh@ti.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
