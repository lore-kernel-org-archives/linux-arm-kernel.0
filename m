From: olof@lixom.net (Olof Johansson)
Date: Mon, 9 Jan 2017 19:11:53 -0800
Subject: [PATCH] ARM, ARM64: dts: drop "arm,amba-bus" in favor of
 "simple-bus" part 3
In-Reply-To: <1482853886-7932-1-git-send-email-yamada.masahiro@socionext.com>
References: <1482853886-7932-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20170110031153.GD22261@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2016 at 12:51:26AM +0900, Masahiro Yamada wrote:
> Tree-wide replacement was done by commit 2ef7d5f342c1 ("ARM, ARM64:
> dts: drop "arm,amba-bus" in favor of "simple-bus"), then the 2nd
> round by commit 15b7cc78f095 ("arm64: dts: drop "arm,amba-bus" in
> favor of "simple-bus" part 2").
> 
> Here, some new users have appeared for Linux v4.10-rc1.  Eliminate
> them now.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Hi Arnd, Olof,
> 
> Can you pick this up for v4.10 fixes?
> 
> If we carry arm,amba-bus until the release, we will need to
> take more time to deprecate it.

Applied to fixes for 4.10.


Thanks,

-Olof
