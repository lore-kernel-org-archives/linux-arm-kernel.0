From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 14 Dec 2013 22:58:10 +0100
Subject: [PATCH 0/5] ARM: sunxi: Add driver for SD/MMC hosts found on
 allwinner sunxi SOCs
Message-ID: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This patchset adds support for the SD/MMC hosts found on sun4i, sun5i and
sun7i SOCs. It is based on the driver Allwinner ships in their Android kernel
sources.

Initial porting to upstream kernels done by David Lanzend?rfer.

I've spend a lot of time cleaning this up, so hopefuly it is ready to go
upstream now, please review.

Note David Lanzend?rfer will maintain this driver in the future. I jumped into
the process of creating this driver to iron out a few blocker bugs and ended
up also doing a lot of cleanup as David was busy. David should have time to
work on this again now, so if a v2 of the patch-set is needed, he will likely
post it.

Thanks & Regards,

Hans
