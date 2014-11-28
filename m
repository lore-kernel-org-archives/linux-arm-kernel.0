From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Sat, 29 Nov 2014 00:41:35 +0200
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <201411282241.12095@pali>
References: <20141027200008.GR2560@atomide.com> <201411271232.47231@pali>
 <20141128202719.GU2817@atomide.com> <201411282241.12095@pali>
Message-ID: <20141128224134.GB1382@fuloong-minipc.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 28, 2014 at 10:41:12PM +0100, Pali Roh?r wrote:
> uboot (in mode when is loaded from NOLO) has those issues:
> 
> 1) uboot cannot read n900 onenand mtd (uboot onenand driver not
> working, do not know why)
> 2) missing support for battery charging (can totally discharge
> battery)

NOLO enables watchdogs when booting. So if you get stuck in the U-boot
for whatever reason the device will power off after ~30 secs or so.

A.
