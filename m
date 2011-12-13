From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Tue, 13 Dec 2011 17:40:51 +0800
Subject: [PATCH V2 0/2] pinctrl: support PXA series
Message-ID: <1323769253-22580-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog v1->v2:
1. Split pxa3xx pinmux driver to more pieces.
2. Add PXA168/PXA910/PXA930/MMP2 silicon support.
3. Now only enable it in arch-mmp.
4. Now all predefined pins are enabled by default. Although some devices
are not used, they would be declared in arch-pxa. It would result define
unnecessary pins in platform.
5. Remove gpio support since it's depend on some gpio-pxa patches in
arm-soc trees.
