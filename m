From: dwmw2@infradead.org (David Woodhouse)
Date: Sat, 05 Mar 2016 00:28:38 +0000
Subject: [PATCH] mtd: only use __xipram annotation when XIP_KERNEL is set
In-Reply-To: <20160305002203.GF55664@google.com>
References: <1453736525-1959191-2-git-send-email-arnd@arndb.de>
 <20160305000225.GB55664@google.com> <5158260.vK2YuWzYIn@wuerfel>
 <20160305002203.GF55664@google.com>
Message-ID: <1457137718.43867.266.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-03-04 at 16:22 -0800, Brian Norris wrote:
> 
> ...but, does anyone care about XIP / MTD_XIP then, if the first two
> examples we have both have long-standing build issues?

I think there are people trying to make it work on other platforms,
yes.

-- 
David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 5691 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160305/caad6369/attachment-0001.bin>
