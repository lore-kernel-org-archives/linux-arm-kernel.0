From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Fri, 28 Nov 2014 23:49:00 +0100
Subject: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
In-Reply-To: <20141128224134.GB1382@fuloong-minipc.musicnaut.iki.fi>
References: <20141027200008.GR2560@atomide.com> <201411282241.12095@pali>
 <20141128224134.GB1382@fuloong-minipc.musicnaut.iki.fi>
Message-ID: <201411282349.00487@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 28 November 2014 23:41:35 Aaro Koskinen wrote:
> Hi,
> 
> On Fri, Nov 28, 2014 at 10:41:12PM +0100, Pali Roh?r wrote:
> > uboot (in mode when is loaded from NOLO) has those issues:
> > 
> > 1) uboot cannot read n900 onenand mtd (uboot onenand driver
> > not working, do not know why)
> > 2) missing support for battery charging (can totally
> > discharge battery)
> 
> NOLO enables watchdogs when booting. So if you get stuck in
> the U-boot for whatever reason the device will power off
> after ~30 secs or so.
> 
> A.

Not truth!

Uboot RX51 code periodically kick watchdogs if are enabled. I 
implemented that before RX51 uboot was merged into mainline.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141128/5e87b2bf/attachment-0001.sig>
