From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 22 Oct 2014 21:48:22 +0200
Subject: [GIT PULL] arm: pxa: fixes against v3.18-rc1
In-Reply-To: <87h9yy0wra.fsf@free.fr> (Robert Jarzmik's message of "Tue, 21
 Oct 2014 08:20:25 +0200")
References: <87h9yy0wra.fsf@free.fr>
Message-ID: <87ppdjlwc9.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think I messed up the email address, thinking the alias arm at linux.org
represented the arm soc maintainers.

As this is the first time I ask you to pull, it might be time to educate me with
what I'm doing wrong, either in my timing, the content, or anything else.

This was the pull request I wanted to send.

--<8--

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git@github.com:rjarzmik/linux.git tags/fixes-for-v3.18-rc2

for you to fetch changes up to cde7fc879969f933614b1256df2625d6ff637bab:

  ARM: pxa: fix hang on startup with DEBUG_LL (2014-10-20 21:11:40 +0200)

----------------------------------------------------------------
arm: pxa: fixes for v3.18-rc2

Hello Arnd, Kevin, Olof,

One small fix for a bug triggered by the activation of low level debug
code in all pxa variants in v3.17. The fix is a trivial Kconfig value
fix for an addressing conflict.

Thanks.

----------------------------------------------------------------
Robert Jarzmik (1):
      ARM: pxa: fix hang on startup with DEBUG_LL

 arch/arm/Kconfig.debug                    | 2 +-
 arch/arm/mach-pxa/include/mach/addr-map.h | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
Robert
