From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Wed, 28 Jan 2015 14:38:46 +0100
Subject: [PATCH] ARM: /proc/atags: Export also for DT
In-Reply-To: <alpine.LFD.2.11.1501272027390.1322@knanqh.ubzr>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <20150127223331.GP26493@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1501272027390.1322@knanqh.ubzr>
Message-ID: <201501281438.46942@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 January 2015 03:07:43 Nicolas Pitre wrote:
> In other words, what prevents someone from creating, say, a
> custom minimal Barebox version that sits on top of the
> existing N900 bootloader?  Wouldn't that provide a much
> better user experience?
> 

Strong cryptography used for signing first stage bootloader, 
undocumented interface and other stuff which initialize HW and 
small memory (about 100kB) for second stage non-signed 
bootloader. Next kernel image is limited to size 2MB. And 
currently uboot can be compiled to act as "kernel" image, so 
second stage bootloader can boot it.

I spend some time to replace second (non signed) bootloader with 
something other, but really it is not possible.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150128/3a1db462/attachment.sig>
