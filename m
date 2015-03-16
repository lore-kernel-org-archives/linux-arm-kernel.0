From: pali.rohar@gmail.com (Pali =?utf-8?q?Roh=C3=A1r?=)
Date: Mon, 16 Mar 2015 21:58:50 +0100
Subject: [PATCH v6 6/6] wlcore: remove wl12xx_platform_data
In-Reply-To: <20150316152939.GP5264@atomide.com>
References: <1426162154-8716-1-git-send-email-eliad@wizery.com>
 <2070859.WcMooC33YH@wuerfel> <20150316152939.GP5264@atomide.com>
Message-ID: <201503162158.50587@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 March 2015 16:29:39 Tony Lindgren wrote:
> I believe the last pending issues is the support for
> ATAG_REVISION in device tree mode as posted by Pali.
> 

No. In DT boot there is missing /proc/atags file (readable by 
userspace processes). And also broken AES/SHA/MD5 support. Fix 
for crypto DT stuff I already sent.

-- 
Pali Roh?r
pali.rohar at gmail.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150316/aca9916c/attachment.sig>
