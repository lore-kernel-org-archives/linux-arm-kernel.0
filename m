From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 10 Mar 2010 08:18:31 -0500
Subject: [PATCH 0/4] enable sound in pxa168
Message-ID: <771cded01003100518v2992dc7ft16e0478c683d70d8@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are used to enable sound in pxa168 SoC. The platform is
aspenite. Since SSP clock is changed in PXA168, create a new
pxa168-ssp.c file in sound/soc/pxa directory.

0001--ARM-pxa-move-ssp-into-plat.patch
0002--ARM-mmp-support-ssp-in-pxa168.patch
0003-ASoC-enable-ssp-on-aspenite.patch
0004--ARM-mmp-enable-sound-in-aspenite.patch

Thanks
Haojian
