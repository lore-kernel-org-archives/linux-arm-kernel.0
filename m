From: nsekhar@ti.com (Sekhar Nori)
Date: Sun, 20 Nov 2016 19:10:36 +0530
Subject: [GIT PULL 2/4] DaVinci SoC updates for v4.10 (part 2)
In-Reply-To: <20161120134038.14998-1-nsekhar@ti.com>
References: <20161120134038.14998-1-nsekhar@ti.com>
Message-ID: <20161120134038.14998-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit ced95ac0815501f47a6041548d70d8900400912d:

  ARM: davinci: da8xx: register USB PHY clocks in the DT file (2016-11-01 15:24:24 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git davinci-for-v4.10/soc-2

for you to fetch changes up to 7e431af8fa0b9ed9d74378c99514856211cb9db8:

  ARM: davinci: PM: support da8xx DT platforms (2016-11-16 14:45:07 +0530)

----------------------------------------------------------------
Adds suspend-to-RAM support for DT boot mode
on DA850.

----------------------------------------------------------------
Kevin Hilman (1):
      ARM: davinci: PM: support da8xx DT platforms

 arch/arm/mach-davinci/da8xx-dt.c | 1 +
 1 file changed, 1 insertion(+)
