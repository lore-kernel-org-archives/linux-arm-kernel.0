From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 02 Dec 2015 10:39:37 +0900
Subject: [GIT PULL 0/9] ARM: EXYNOS: Pull request for v4.5
Message-ID: <1449020386-20250-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

A lot of stuff for v4.5 with 3 dependencies split into
separate tags. The need for dependency is explained both
in merge-commit and in description of a tag which is using
the dependency.

The order goes like (but of course dependencies
could be pulled all at once at beginning):
1. tags/samsung-dt-syscon-restart-4.5
2. tags/samsung-soc-4.5
3. tags/samsung-clk-arm64-symbols-4.5
4. tags/samsung-soc64-4.5
5. tags/samsung-drivers-4.5
6. tags/samsung-clk-exynos4-4.5
7. tags/samsung-dt-4.5
8. tags/samsung-dt64-4.5
9. tags/samsung-defconfig-4.5

I split dependencies to three tags so clock or other folks could
easily grab them if needed.

Please share your comments or pull as early as possible as we have here
some more dependencies than usual.


Kind regards,
Krzysztof
