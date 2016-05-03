From: christo.radev@gmail.com (christo.radev at gmail.com)
Date: Tue, 3 May 2016 00:12:06 -0700 (PDT)
Subject: [PATCH 1/1] ARM: dts: sunxi: Add a olinuxino-lime2-emmc
In-Reply-To: <1461827998-12192-1-git-send-email-oliver@schinagl.nl>
References: <1461827998-12192-1-git-send-email-oliver@schinagl.nl>
Message-ID: <f3da30a6-9ac0-4d5e-8611-ebb80cb3589e@googlegroups.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi to All,

I have already solved and tested this issue on Armbian build.
Find patches for both legacy (3.4.111) and mainline (4.5.2) kernels on:
http://forum.armbian.com/index.php/topic/853-armbian-customization/page-2#entry7494
There it is also described how to do eMMC bootable and much more.

About the board - Olimex already sold all 3 kinds after migration to their HW rev. E. One have to specify Lime2-eMMC as A20-Olinuxino-Lime2-eMMC instead of their old 2 options A20-Olinuxino-Lime2(-4GB).

Regards
Chris
