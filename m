From: mark.brown314@gmail.com (Mark F. Brown)
Date: Wed, 25 Aug 2010 23:51:53 -0400
Subject: [PATCH v3 0/2] added initial support for TPO TD043MTEA1 LCD display
	on Aspenite
Message-ID: <1282794715-28640-1-git-send-email-mark.brown314@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark F. Brown (2):
  pxa168: added framebuffer support code.
  pxa168: added initial support for TPO TD043MTEA1 LCD display on
    Aspenite

 arch/arm/mach-mmp/aspenite.c            |   60 +++++++++++++++++++++++++++++++
 arch/arm/mach-mmp/include/mach/pxa168.h |    8 ++++
 arch/arm/mach-mmp/pxa168.c              |    3 ++
 3 files changed, 71 insertions(+), 0 deletions(-)
