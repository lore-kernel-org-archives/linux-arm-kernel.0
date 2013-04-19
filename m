From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 19 Apr 2013 22:58:36 +0200
Subject: linux-next ARM multi-platform randconfig errors
In-Reply-To: <20130419204028.GU10155@atomide.com>
References: <5170B4C6.1030300@gmail.com> <201304192211.13356.arnd@arndb.de>
 <20130419204028.GU10155@atomide.com>
Message-ID: <201304192258.36276.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 19 April 2013, Tony Lindgren wrote:
> Yeah. Here's an initial patch of what I had in mind, seems to
> do the trick. Will spend a little more time looking at it.

I suspect it won't be enough, as the same bugs you see with all of
them disable will likely happen also when you disable most of them.
If I'm right, the only solution is to look at each symbol individually
to find out exactly what code provides that symbol and ensure it
does not get used otherwise.

	Arnd
