From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 10 Jun 2013 13:05:20 +0800
Subject: [GIT PULL] SiRF V3.10 kernel Panic fix for multiplatforms using
 non-SiRF SoCs
Message-ID: <CAGsJ_4ytD0L8gtcioDxJRyoOL6BGcEKQSxeyrJz6Ko5hXS4VnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:

  Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

  git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git
tags/sirf-fix-v3.10-mp-panic

for you to fetch changes up to b32b28406f830a526db1bacd539bee57692b0847:

  ARM: prima2: fix incorrect panic usage (2013-06-10 12:01:06 +0800)

----------------------------------------------------------------
SiRF fixes kernel panic on multi-platforms using non-sirf soc

- ARM: prima2: fix incorrect panic usage

----------------------------------------------------------------
Haojian Zhuang (1):
      ARM: prima2: fix incorrect panic usage

 arch/arm/mach-prima2/pm.c   | 6 ++++--
 arch/arm/mach-prima2/rstc.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)
