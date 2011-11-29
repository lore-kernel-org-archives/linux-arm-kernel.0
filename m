From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Nov 2011 17:42:06 +0000
Subject: [PATCH 0/6] AT91 Reset cleanup
In-Reply-To: <20111129173514.GW15008@game.jcrosoft.org>
References: <20111129173514.GW15008@game.jcrosoft.org>
Message-ID: <20111129174206.GK9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 06:35:14PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> Hi,
> 
> 	the following patch series will merge the ddr controler header file
> 	for sam9 and cap9 and cleanup the reset by
> 
> 	swtich to arm_pm_restart
> 	fix the sam9g45 and cap9 reset
> 	make rstc soc independent
> 
> The following changes since commit 15327570807209b5c088382af23ed3fc47558d87:
> 
>   ARM: at91/gpio: fix display of number of irq setuped (2011-11-28 22:53:09 +0800)
> 
> are available in the git repository at:
>   git://github.com/at91linux/linux-at91.git for-arnd-3.3-reset
> 
> Jean-Christophe PLAGNIOL-VILLARD (6):
>       ARM: at91: fix cap9 ddrsdr register
>       ARM: at91: merge at91cap9_ddrsdr.h in at91sam9_ddrsdr.h
>       ARM: at91: introduce AT91_SAM9_ALT_RESET to select the at91sam9 alternative reset
>       ARM: restart: at91: use new restart hook

Well, it looks like you've taken my work here and committed it as yourself.
That's plagerism.  Don't do it - and fix it before someone pulls your crap.
