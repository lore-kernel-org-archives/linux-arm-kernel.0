From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 22 May 2010 10:46:37 +0100
Subject: Initrd and 2.6.33 curious behaviour
In-Reply-To: <87fx1k46qg.fsf@free.fr>
References: <874oi157c6.fsf@free.fr>
	<20100521204343.GA18032@n2100.arm.linux.org.uk>
	<87fx1k46qg.fsf@free.fr>
Message-ID: <20100522094637.GA954@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 22, 2010 at 11:37:43AM +0200, Robert Jarzmik wrote:
> Or alternatively, is there a clever way of storing some data relative to
> reserve_bootmem_node() or __reserve() to be printed at the tail of kernel log
> (ie. in do_mounts_rd()) which would help me investigate ?

You could boot with 'quiet' so that the kernel shuts up most of the
noisy kernel messages.
