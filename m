From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 May 2015 17:21:55 +0200
Subject: [PATCH] ARM: uniphier: only select TWD for SMP
In-Reply-To: <CAK7LNAQdndXzphHquZJRVwHwfRa5uOfeaQpWZ151PN8FNg9xGw@mail.gmail.com>
References: <2227073.rylFc5jIqu@wuerfel> <2076486.2f0MnouCnx@wuerfel>
 <CAK7LNAQdndXzphHquZJRVwHwfRa5uOfeaQpWZ151PN8FNg9xGw@mail.gmail.com>
Message-ID: <2163738.HLjmavUv0R@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 May 2015 09:52:13 Masahiro Yamada wrote:
> 
> OK, then.  Anyway, we should fix the build error asap.
> Let's go with "if SMP" for now.
> 
> Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> 

Applied now, thanks!

	Arnd
