From: greg@kroah.com (Greg KH)
Date: Mon, 7 Mar 2011 13:09:50 -0800
Subject: [PATCH v11 1/1] PRUSS UIO driver support
In-Reply-To: <20110305003004.GA1295@local>
References: <1299279617-21108-1-git-send-email-pratheesh@ti.com>
	<1299279617-21108-2-git-send-email-pratheesh@ti.com>
	<20110305003004.GA1295@local>
Message-ID: <20110307210950.GA21433@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 05, 2011 at 01:30:04AM +0100, Hans J. Koch wrote:
> On Sat, Mar 05, 2011 at 04:30:17AM +0530, Pratheesh Gangadhar wrote:
> > This patch implements PRUSS (Programmable Real-time Unit Sub System)
> > UIO driver which exports SOC resources associated with PRUSS like
> > I/O, memories and IRQs to user space. PRUSS is dual 32-bit RISC
> > processors which is efficient in performing embedded tasks that
> > require manipulation of packed memory mapped data structures and
> > handling system events that have tight real time constraints. This
> > driver is currently supported on Texas Instruments DA850, AM18xx and
> > OMAP-L138 devices.
> > For example, PRUSS runs firmware for real-time critical industrial
> > communication data link layer and communicates with application stack
> > running in user space via shared memory and IRQs.
> > 
> > Signed-off-by: Pratheesh Gangadhar <pratheesh@ti.com>
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Signed-off-by: Hans J. Koch <hjk@hansjkoch.de>
> 
> I think, we've got it. Thanks for your contribution and your patience.
> Not many UIO programmers hang on through 11 patch versions...

Thanks so much for all of you doing this review as well, that too take
persistance :)

greg k-h
