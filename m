From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Tue, 08 Jan 2013 10:30:45 +0100
Subject: [PATCH RESEND] ARM: dts: AM33XX: Rename I2C and GPIO nodes
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EAD4863@DBDE01.ent.ti.com>
 (Chimata AnilKumar's message of "Wed, 2 Jan 2013 10:12:29 +0000")
References: <1353498737-21174-1-git-send-email-anilkumar@ti.com>
 <331ABD5ECB02734CA317220B2BBEABC13EAD4863@DBDE01.ent.ti.com>
Message-ID: <8738ycaunu.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "AnilKumar" == AnilKumar, Chimata <anilkumar@ti.com> writes:

 AnilKumar> On Wed, Nov 21, 2012 at 17:22:17, AnilKumar, Chimata wrote:
 >> Rename I2C and GPIO nodes according to AM33XX TRM. According to
 >> AM33XX TRM device instances are starting from "0" like i2c0, i2c1
 >> and i2c3.
 >> 
 >> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
 >> [panto at antoniou-consulting.com: initial patch by pantelis's]
 >> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
 >> ---
 >> Changes from first version:
 >> - Updated pantelis's patch
 >> * Modified based on linux-omap/master
 >> * Added GPIO nodes renaming as well

 AnilKumar> Hi Tony/Benoit,

 AnilKumar> If there are no comments could you please pull this patch?

Yes, please do.

-- 
Bye, Peter Korsgaard
