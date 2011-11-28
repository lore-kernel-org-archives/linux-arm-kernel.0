From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Nov 2011 18:58:54 +0000
Subject: [AT91 PULL] gpio cleanup pull request for 3.3
In-Reply-To: <20111123171935.GC15531@game.jcrosoft.org>
References: <20111123171935.GC15531@game.jcrosoft.org>
Message-ID: <201111281858.54217.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 23 November 2011, Jean-Christophe PLAGNIOL-VILLARD wrote:
>         this pull containt the first patch series that rework the gpio to make it more standard
>         and to allow the multi soc and simplify the adding of the DT
>         
>         this pull depends on previous one for the ioremaps
>         
> The following changes since commit 55c71f1a3e29cc7cd761a358deac96d3e952128f:
> 
>   ARM: at91: make rm9200 rtc drivers soc independent (2011-11-23 23:00:11 +0800)
> 

For some reason, this series contains another patch that you have
not mentioned: "macb: unify at91 and avr32 platform data" from Jamie.
The patch looks ok, but it seems that you have included it unintentionally.

What should I do with this? I can rebase the series to leave that patch out,
or I could apply it as well.

	Arnd
