From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Thu, 24 Dec 2015 18:48:17 +0100
Subject: [PATCH 1/2] ARM: ATAGS: move save_atags() to include/asm
 arch/arm/include/asm/setup.h
In-Reply-To: <1450975076-7411-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
References: <20151224153536.GJ30871@n2100.arm.linux.org.uk>
 <1450975076-7411-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1450975076-7411-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
Message-ID: <201512241848.17946@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 December 2015 17:37:55 Ivaylo Dimitrov wrote:
> So it can be used by code outside arch/arm/kernel/. Fix save_atags()
> declaration to match its definition while at it.
> 
> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151224/1ed825de/attachment.sig>
