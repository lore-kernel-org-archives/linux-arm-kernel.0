From: olof@lixom.net (Olof Johansson)
Date: Sat, 10 Mar 2012 09:22:27 -0800
Subject: [PATCH 1/5] ARM: EXYNOS: replace clock.c for other new EXYNOS SoCs
In-Reply-To: <1331374749-23256-2-git-send-email-kgene.kim@samsung.com>
References: <1331374749-23256-1-git-send-email-kgene.kim@samsung.com>
 <1331374749-23256-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <20120310172227.GA5972@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 10, 2012 at 02:19:05AM -0800, Kukjin Kim wrote:
> This patch changes the name of clock.c to clock-exynos4.c for other
> EXYNOS series such as EXYNOS5. And since the header file of clock
> is used only in arch/arm/mach-exynos, moves it in the local directory.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

Thanks, much easier to review this way!

Ideally the whitespace cleanup could also be split up to a separate
patch that has _no_ contents changes besides whitespace, but this is OK
too since it's easy to see what's a change and not anyway.


-Olof
