From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 15 May 2011 08:33:26 +0100
Subject: Kernel oops with undefined instruction when accessing memory
	on an AT91 custom system
In-Reply-To: <4DCF4CF8.3020209@usask.ca>
References: <4DCEADB5.9010905@usask.ca> <4DCEE989.4000401@atmel.com>
	<4DCF4CF8.3020209@usask.ca>
Message-ID: <20110515073326.GG30539@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 14, 2011 at 09:48:08PM -0600, Nicholas Kinar wrote:
> 0/  I do not own an Atmel at91sam9rl-ek board (I wish that I did), but I  
> would hope to obtain one of these in the near future.
> 1/  I am building this hardware for a research project, so I've only  
> created only one PCB.  Eventually, I intend to make many more copies of  
> this design.
> 2/  I've tried the same test with all of the caches disabled, and the  
> system runs very slowly (and consumes more power).  However, I still  
> receive a kernel oops when running the mtest program (the SD card was  
> not mounted and the caches were off):

This all looks like either noisy SDRAM signals or power problems for
the CPU itself causing corruption.
