From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sun, 23 May 2010 02:23:33 +0200
Subject: Initrd and 2.6.33 curious behaviour
In-Reply-To: <20100522094637.GA954@n2100.arm.linux.org.uk> (Russell King's
	message of "Sat\, 22 May 2010 10\:46\:37 +0100")
References: <874oi157c6.fsf@free.fr>
	<20100521204343.GA18032@n2100.arm.linux.org.uk>
	<87fx1k46qg.fsf@free.fr> <20100522094637.GA954@n2100.arm.linux.org.uk>
Message-ID: <87pr0n31q2.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> You could boot with 'quiet' so that the kernel shuts up most of the
> noisy kernel messages.

With "quiet" option, the kernel console outputs only 1 line :
"Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)"

--
Robert
