From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 2 Jan 2010 12:06:19 +0000
Subject: your mail
In-Reply-To: <20091002145315.GB25736@avionic-design.de>
References: <1250258343-14203-1-git-send-email-thierry.reding@avionic-design.de>
	<20091002145315.GB25736@avionic-design.de>
Message-ID: <20100102120618.GE2529@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 02, 2009 at 04:53:15PM +0200, Thierry Reding wrote:
> * Thierry Reding wrote:
> > So it's been quite a while since I last posted this series and there have been
> > a number of changes.
> > 
> > Support for T-Pid analog variants is dropped and will be handled in user-space
> > instead. There hardware does not differ from the standard T-Pid. This gets rid 
> > of some ugly platform-specific #ifdefs.
> > 
> > Front-panel controls are now handled in a separate driver, adx-keypad. That
> > way backlight control can be moved to userspace.
> > 
> > This series also adds a watchdog driver that can be used on all Avionic Design
> > Xanthos-based boards.
> 
> Russell,
> 
> with the watchdog and backlight drivers out of the way, would you like me to
> get any of the other drivers (fb, keypad) in via seperate trees or can they go
> in through the ARM tree?

They should go in via the relevant driver trees.
