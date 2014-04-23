From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 23 Apr 2014 15:46:44 +0100
Subject: [GIT PULL] arm: omap: Immutable branch between MFD and ARM OMAP due
 for the v3.16 merge-window
In-Reply-To: <20140417153722.GA23385@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-11-git-send-email-tony@atomide.com>
 <20140417080051.GE28725@lee--X1>
 <20140417153722.GA23385@atomide.com>
Message-ID: <20140423144644.GF6264@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Sorry for the delay - I've been snowed under recently.

As requested, you patch based on v3.14 ( for some reason :) ).

The following changes since commit 455c6fdbd219161bd09b1165f11699d6d73de11c:

  Linux 3.14 (2014-03-30 20:40:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/ib-mfd-omap-3.16

for you to fetch changes up to a613b739b8c08eab811e677810045cc0522fc3e6:

  mfd: twl-core: Fix idle mode signaling for omaps when booted with device tree (2014-04-23 15:31:05 +0100)

----------------------------------------------------------------
Immutable branch between MFD and ARM OMAP due for v3.16 merge-window.

----------------------------------------------------------------
Tony Lindgren (1):
      mfd: twl-core: Fix idle mode signaling for omaps when booted with device tree

 arch/arm/mach-omap2/omap_twl.c | 60 ------------------------------------------------------------
 drivers/mfd/twl-core.c         | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 60 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
