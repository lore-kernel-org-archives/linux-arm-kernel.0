From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 19 Jun 2013 05:00:16 +0900
Subject: [GIT PULL 04/10] Samsung S3C24XX DT-2 for v3.11
Message-ID: <51C0BC50.3080405@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 35aca36450e6c3fb3b3fe9ea60a7c4689a219a87:

   ARM: dts: add devicetree support for s3c2416-smdk2416 (2013-05-21 
01:06:12 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/s3c24xx-dt-2

for you to fetch changes up to 52c76e44f1b8e63474b9ef5455f657c13e983e95:

   ARM: S3C24XX: update uart addresses in s3c2416-dt auxdata (2013-06-19 
02:40:18 +0900)

----------------------------------------------------------------
based on tags/s3c24xx-dt-1
- update uart addresses in s3c2416-dt auxdata due to removing 
S3C2410_PA_UARTX

----------------------------------------------------------------
Heiko Stuebner (1):
       ARM: S3C24XX: update uart addresses in s3c2416-dt auxdata

  arch/arm/mach-s3c24xx/mach-s3c2416-dt.c | 8 ++++----
  1 file changed, 4 insertions(+), 4 deletions(-)
