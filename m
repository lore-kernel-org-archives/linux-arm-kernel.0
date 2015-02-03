From: davem@davemloft.net (David Miller)
Date: Mon, 02 Feb 2015 18:54:01 -0800 (PST)
Subject: [PATCH] net/tulip: don't warn about unknown ARM architecture
In-Reply-To: <1780413.LLpv9s01CB@wuerfel>
References: <1780413.LLpv9s01CB@wuerfel>
Message-ID: <20150202.185401.1529004777101807716.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 30 Jan 2015 22:58:19 +0100

> ARM has 32-byte cache lines, which according to the comment in
> the init registers function seems to work best with the default
> value of 0x4800 that is also used on sparc and parisc.
> 
> This adds ARM to the same list, to use that default but no
> longer warn about it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks a lot.
