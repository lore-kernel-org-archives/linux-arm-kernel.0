From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 29 May 2013 23:51:40 +0200
Subject: Single zImage and A15/LPAE
In-Reply-To: <20130529151555.GP17767@MacBook-Pro.local>
References: <50735B75.8070109@wwwdotorg.org> <2274563.opVbLLPT1p@wuerfel>
 <20130529151555.GP17767@MacBook-Pro.local>
Message-ID: <201305292351.41096.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 May 2013, Catalin Marinas wrote:
> > I think to do this right, we need to treat ARMv7+LPAE as a separate
> > architecture level, just like we treat ARMv6, ARMv7 as separate
> > compatible architectures. BTW, is there an official name for that
> > architecture?
> 
> The official is Large Physical Address Extension which is an extension
> to ARMv7, so not a new architecture.

Ah, too bad. I had hoped there were still postfixes like v6K or v4T.
I guess there is no complete list of ARMv7 extensions anywhere, right?

	Arnd
