From: mark.brown314@gmail.com (Mark F. Brown)
Date: Tue, 24 Aug 2010 22:02:29 -0400
Subject: [PATCH 0/1] added initial support for TPO TD043MTEA1 LCD display on
	Aspenite
Message-ID: <1282701750-4949-1-git-send-email-mark.brown314@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds basic support for TD043MTEA1 LCD display for Aspenite board.
This patch is generated against Eric Miao's pxa-linux-2.6 tree devel branch.

Mark F. Brown (1):
  pxa168: added initial support for TPO TD043MTEA1 LCD display on
    Aspenite

 arch/arm/configs/pxa168_defconfig       |   10 +++++
 arch/arm/mach-mmp/aspenite.c            |   59 +++++++++++++++++++++++++++++++
 arch/arm/mach-mmp/include/mach/pxa168.h |    8 ++++
 arch/arm/mach-mmp/pxa168.c              |    4 ++
 drivers/video/pxa168fb.c                |    4 +-
 5 files changed, 83 insertions(+), 2 deletions(-)
