From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 21 Nov 2013 11:09:50 +0000
Subject: [PATCH 1/5] mfd: twl-core: Fix passing of platform data in the
 device tree case
In-Reply-To: <20131121104654.GA23067@lee--X1>
References: <1384562167-14725-1-git-send-email-tony@atomide.com>
 <1384562167-14725-2-git-send-email-tony@atomide.com>
 <20131118102907.GC13640@lee--X1>
 <20131118172510.GI16038@saruman.home>
 <20131118174638.GQ13640@lee--X1>
 <20131118181110.GM10317@atomide.com>
 <20131118190921.GT13640@lee--X1>
 <20131118192256.GU10317@atomide.com>
 <20131121104654.GA23067@lee--X1>
Message-ID: <20131121110950.GC23067@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Here Tony, you can take this one.
> 
> I will simply apply my other fixes on top of it.
> 
> The issue is, I will most likely have to rebase it on top of -rc1 prior
> to sending a request to Linus, so in that regard it's not exactly
> immutable.
> 

Ignore the above. This is what you want:

The following changes since commit 5e01dc7b26d9f24f39abace5da98ccbd6a5ceb52:

  Linux 3.12 (2013-11-03 15:41:51 -0800)

are available in the git repository at:

  git://git.linaro.org/people/ljones/mfd.git tags/ib-tony

for you to fetch changes up to f984370913d3ba5d13806cc8ac6fc26f8ebd1694:

  mfd: twl-core: Fix passing of platform data in the device tree case (2013-11-21 10:42:36 +0000)

----------------------------------------------------------------
warning: refname 'ib-tony' is ambiguous.
Immutable branch for Tony Lindgren

----------------------------------------------------------------
Tony Lindgren (1):
      mfd: twl-core: Fix passing of platform data in the device tree case

 drivers/mfd/twl-core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
