From: manjunath.hadli@ti.com (Hadli, Manjunath)
Date: Wed, 8 Feb 2012 12:41:14 +0000
Subject: [RESEND PATCH] davinci: CQ93VC: remove machine specific header
 file inclusion from codec driver
In-Reply-To: <20120110184741.GG7164@opensource.wolfsonmicro.com>
References: <1326194863-31194-1-git-send-email-manjunath.hadli@ti.com>
 <20120110184741.GG7164@opensource.wolfsonmicro.com>
Message-ID: <E99FAA59F8D8D34D8A118DD37F7C8F753174E3EC@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark,

On Wed, Jan 11, 2012 at 00:17:41, Mark Brown wrote:
> On Tue, Jan 10, 2012 at 04:57:43PM +0530, Manjunath Hadli wrote:
> > remove unnecessary inclusion of machine specific header file 
> > mach/dm365.h from cq93vc.c voice codec driver which comes in the way 
> > of platform code consolidation.
> 
> Applied but please do try to use a subject line appropriate for the subsystem you're contributing to.
I still can't find this patch in the mainline, any issues?

Regards,
--Manju
> 
