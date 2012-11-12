From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 12 Nov 2012 14:03:05 +0900
Subject: [PATCH 2/4] gpio: samsung: Skip registration if pinctrl driver is
 present on Exynos4x12
In-Reply-To: <CACRpkdZGu2VfP-EzAOxK3947x6Pd78bh=TWDK98iXwkJx2WiTQ@mail.gmail.com>
References: <1351089457-8205-1-git-send-email-t.figa@samsung.com>
 <1351089457-8205-3-git-send-email-t.figa@samsung.com>
 <CACRpkdYNDSp0K3wpvUem9ecsW-JQ9L6aKqaOmHNUR65DQTMNHA@mail.gmail.com>
 <0c5301cdbca2$30320240$909606c0$%kim@samsung.com>
 <CACRpkdaOpzFvs_wqy9sdrmx1=wEs5uxqfh_rOrKxLTXV-q1K2Q@mail.gmail.com>
 <0e8301cdbe62$56a1d010$03e57030$%kim@samsung.com>
 <CACRpkdZGu2VfP-EzAOxK3947x6Pd78bh=TWDK98iXwkJx2WiTQ@mail.gmail.com>
Message-ID: <004b01cdc093$00424140$00c6c3c0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> 
> >
> > Can you drop above 3 commits in your tree? If many conflicts happens
> during
> > rebasing, how about that I merge your pinctrl/samsung branch into
> Samsung
> > tree?...
> 
> Why not :-)
> 
> I have removed the samsung branch from my for-next to avoid
> clashes.
> 
Thanks ;-)

> So please bring the samsung branch into you tree and fix
> everything up there.
> 
I did.

> Axel Lin has sent some tree-wide cleanups but let's hope they don't
> hit samsung so much, or they will need to be postponed/dropped.
> 
OK, I see.

Thanks again.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
