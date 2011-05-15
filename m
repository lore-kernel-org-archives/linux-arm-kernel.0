From: n.kinar@usask.ca (Nicholas Kinar)
Date: Sun, 15 May 2011 08:24:36 -0600
Subject: Kernel oops with undefined instruction when accessing memory on an
	AT91 custom system
In-Reply-To: <20110515073326.GG30539@n2100.arm.linux.org.uk>
References: <4DCEADB5.9010905@usask.ca> <4DCEE989.4000401@atmel.com>
	<4DCF4CF8.3020209@usask.ca>
	<20110515073326.GG30539@n2100.arm.linux.org.uk>
Message-ID: <4DCFE224.4040506@usask.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Sat, May 14, 2011 at 09:48:08PM -0600, Nicholas Kinar wrote:
>> 0/  I do not own an Atmel at91sam9rl-ek board (I wish that I did), but I
>> would hope to obtain one of these in the near future.
>> 1/  I am building this hardware for a research project, so I've only
>> created only one PCB.  Eventually, I intend to make many more copies of
>> this design.
>> 2/  I've tried the same test with all of the caches disabled, and the
>> system runs very slowly (and consumes more power).  However, I still
>> receive a kernel oops when running the mtest program (the SD card was
>> not mounted and the caches were off):
> This all looks like either noisy SDRAM signals or power problems for
> the CPU itself causing corruption.
>

Thanks for your response, Russell; this is greatly appreciated.  Is 
there anything that can be done in the kernel code to work around this 
problem?  I've checked the power supplies to the CPU, and these seem to 
be stable.  For dealing with noisy SDRAM signals, is there a way to slow 
down the bus accesses so this problem becomes less apparent?

Nicholas
