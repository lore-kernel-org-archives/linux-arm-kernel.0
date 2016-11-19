From: olof@lixom.net (Olof Johansson)
Date: Fri, 18 Nov 2016 18:00:37 -0800
Subject: [GIT PULL 1/2] arm64: dts: exynos: Topic dts arm64 for v4.10
In-Reply-To: <1479473075-9787-1-git-send-email-krzk@kernel.org>
References: <1479473075-9787-1-git-send-email-krzk@kernel.org>
Message-ID: <20161119020037.GI2543@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 18, 2016 at 02:44:34PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Topic branch with a GIC interrupt fix and cleanup. No conflicts expected.
> No dependencies.
> 
> Best regards,
> Krzysztof
> 
> 
> The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:
> 
>   Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-gic-flags-4.10
> 
> for you to fetch changes up to 86bb573d0b2a8e876a12d1348bd0b6e377c1043e:
> 
>   arm64: dts: exynos: Use human-friendly symbols for interrupt properties in exynos7 (2016-11-03 22:40:39 +0200)
> 
> ----------------------------------------------------------------
> Topic branch with DT arm64 changes for v4.10.
> 
> Fix invalid GIC interrupt flags - type IRQ_TYPE_NONE is not allowed for GIC
> interrupts.  Although this was working but with error messages like:
>         genirq: Setting trigger mode 0 for irq 16 failed
> 
> Use level high interrupt instead of type none.  The choice of level high was
> rather an arbitrary decision hoping it will work on each platform.  Tests shown
> no issues so far.

Merged, thanks.


-Olof
