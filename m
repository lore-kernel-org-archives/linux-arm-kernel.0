From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 20 Aug 2011 14:05:55 +0900
Subject: [PATCH 0/4] ARM: SAMSUNG: Add support CPU ID and Rev. at runtime
Message-ID: <1313816759-14564-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support handling of CPU ID and varialble silicon revision
at runtime.

[PATCH 1/4] ARM: SAMSUNG: Add support for detecting CPU at runtime
[PATCH 2/4] ARM: S5P64X0: Use cpu_is_s5p64x0() to distinguish cpu at runtime
[PATCH 3/4] ARM: SAMSUNG: Add support for handling of cpu revision
[PATCH 4/4] ARM: EXYNOS4: Use samsung_rev() to distinguish silicon revision
