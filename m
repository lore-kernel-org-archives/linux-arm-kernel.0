From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 26 Sep 2013 10:08:03 +0200
Subject: [PATCH 12/26] ARM: exynos: remove custom .init_time hook
In-Reply-To: <5243D267.3010704@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1379526839-14798-13-git-send-email-sebastian.hesselbarth@gmail.com>
 <5243D267.3010704@gmail.com>
Message-ID: <1573378.EKN2gyy8Sh@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Thursday 26 of September 2013 08:21:27 Sebastian Hesselbarth wrote:
> On 09/18/2013 07:53 PM, Sebastian Hesselbarth wrote:
> > With arch/arm calling of_clk_init(NULL) from time_init(), we can now
> > remove custom .init_time hooks. While at it, also remove some now
> > redundant includes.
> > 
> > Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > ---
> 
> Ping,

This patch looks fine to me (as the whole series).

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

I don't see any reason why this series could introduce a regression on
Exynos SoCs, but just in case let me test it on selected Exynos4 and 
Exynos5 boards.

Best regards,
Tomasz
