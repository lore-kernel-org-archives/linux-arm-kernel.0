From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 May 2013 15:31:16 +0200
Subject: [PATCH 0/4] ARM: Remove boilerplate debug_ll_io_init code
In-Reply-To: <5194F944.2040803@free-electrons.com>
References: <1368440169-29088-1-git-send-email-maxime.ripard@free-electrons.com>
 <201305160040.54399.arnd@arndb.de> <5194F944.2040803@free-electrons.com>
Message-ID: <201305171531.16240.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 May 2013, Maxime Ripard wrote:

> 
> How will we merge this? The first patch would be merged by Russel and
> the 3 others by their respective maintainers?

I think since it's mostly platform code and all trivial, we can merge
it into the next/cleanup branch in arm-soc directly.

	Arnd
