From: olof@lixom.net (Olof Johansson)
Date: Mon, 5 Nov 2012 09:18:37 -0800
Subject: [PATCH for soc] socfpga: map uart into virtual address space so
 that early_printk() works
In-Reply-To: <20121103112614.GA27365@elf.ucw.cz>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <201210251458.48528.arnd@arndb.de>
 <20121027115615.GC5912@elf.ucw.cz>
 <201210271539.20156.arnd@arndb.de>
 <20121029002724.GA27891@elf.ucw.cz>
 <20121103112614.GA27365@elf.ucw.cz>
Message-ID: <20121105171837.GA16155@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 03, 2012 at 12:26:14PM +0100, Pavel Machek wrote:
> Hi!
> 
> > Early printk code needs UART to be mapped early during
> > boot. early_printk() is left there during the start-up; it is useful
> > as our emulators are fairly slow.
> > 
> > Signed-off-by: Pavel Machek <pavel@denx.de>
> > Acked-by: Dinh Nguyen <dinguyen@altera.com>
> 
> Could we get this one applied? No comments for quite a while... and it
> is needed for machine not to crash with early_printk used...
> 								Pavel

Sorry, we've been delayed on applying patches due to Linaro Connect and travel.

I've applied this now with a minor edit to remove the extra added lines before
the struct.


Regards,


-Olof
