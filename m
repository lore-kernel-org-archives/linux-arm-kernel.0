From: nathan_lynch@mentor.com (Nathan Lynch)
Date: Fri, 17 Apr 2015 16:27:02 -0500
Subject: [PATCH 0/2] ARM: VDSO: minor fixes for 4.1
Message-ID: <1429306024-5253-1-git-send-email-nathan_lynch@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While investigating Arnd's v3 build issue, I became aware of a couple
of shortcomings unrelated to runtime in the VDSO code.  With these
applied, 'make arch/arm/vdso/' should behave better, and .gitignore is
populated properly (I almost always build in a separate directory, so
I hadn't noticed until now).

Nathan Lynch (2):
  ARM: VDSO: add build artifacts to .gitignore
  ARM: VDSO: honor CONFIG_VDSO in Makefile

 arch/arm/vdso/.gitignore | 2 ++
 arch/arm/vdso/Makefile   | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.9.3
