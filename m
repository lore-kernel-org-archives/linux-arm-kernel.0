From: thierry.reding@avionic-design.de (Thierry Reding)
Date: Fri, 2 Oct 2009 16:53:15 +0200
Subject: your mail
In-Reply-To: <1250258343-14203-1-git-send-email-thierry.reding@avionic-design.de>
References: <1250258343-14203-1-git-send-email-thierry.reding@avionic-design.de>
Message-ID: <20091002145315.GB25736@avionic-design.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Thierry Reding wrote:
> So it's been quite a while since I last posted this series and there have been
> a number of changes.
> 
> Support for T-Pid analog variants is dropped and will be handled in user-space
> instead. There hardware does not differ from the standard T-Pid. This gets rid 
> of some ugly platform-specific #ifdefs.
> 
> Front-panel controls are now handled in a separate driver, adx-keypad. That
> way backlight control can be moved to userspace.
> 
> This series also adds a watchdog driver that can be used on all Avionic Design
> Xanthos-based boards.

Russell,

with the watchdog and backlight drivers out of the way, would you like me to
get any of the other drivers (fb, keypad) in via seperate trees or can they go
in through the ARM tree?

Do the remaining patches need additional work or can I go ahead and submit
them to the patch system? Or do you prefer some other way to get them into
your tree?

Thierry
