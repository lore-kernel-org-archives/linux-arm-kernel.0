From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Thu, 24 Dec 2015 18:49:11 +0100
Subject: [PATCH 2/2] OMAP: RX51: save ATAGS data in the early boot stage
In-Reply-To: <1450975076-7411-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <20151224153536.GJ30871@n2100.arm.linux.org.uk>
 <1450975076-7411-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1450975076-7411-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <201512241849.11704@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 December 2015 17:37:56 Ivaylo Dimitrov wrote:
> Nokia N900 (RX51) legacy userspace needs various ATAGS passed by the
> bootloader (boot reason, device serial, boot mode, various GPIO
> swithes, etc). Save that data early enough in the boot process, so
> it can be exported later in /proc/atags
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

Working fine in qemu.

Tested-by: Pali Roh?r <pali.rohar@gmail.com>

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151224/f73d45ee/attachment-0001.sig>
