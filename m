From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 20:27:36 +0000
Subject: [PATCH 1/4] ARM: clps711x/p720t: Replace __initcall by
 .init_early call
In-Reply-To: <1342462908-18547-1-git-send-email-shc_work@mail.ru>
References: <1342462908-18547-1-git-send-email-shc_work@mail.ru>
Message-ID: <201207172027.36677.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 July 2012, Alexander Shiyan wrote:
> Since we are trying to do to support multiple machines in a single kernel,
> we need to eliminate the use of __initcall to be used for all machines.
> Using .init_early call solves this problem.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

I've added patches 1-3 to the next/cleanup branch now.

Let's wait for comments on the clock patch first. My feeling is that
you should be using the clock framework.

	Arnd
