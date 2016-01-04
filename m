From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 4 Jan 2016 18:34:55 +0100
Subject: [PATCH 2/2] memory: omap-gpmc: Add Kconfig option for debug
In-Reply-To: <20160104170206.GC12777@atomide.com>
References: <1432156863-19695-1-git-send-email-tony@atomide.com>
 <568662FC.9050206@gmail.com> <20160104170206.GC12777@atomide.com>
Message-ID: <201601041834.56056@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 January 2016 18:02:06 Tony Lindgren wrote:
> Care to boot with CONFIG_OMAP_GPMC_DEBUG=y and post the gpmc related
> dmesg output?

Hi Tony. We do not have serial console for N900 and so when kernel is 
not fully bootable to userspace we cannot provide dmesg for you :-(

Maybe something with simple initramfs could work, but really if you have 
serial console for N900 it should be for you lot of easier to get it.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/a0f5088e/attachment.sig>
