From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Sat, 17 Jul 2010 18:13:46 +0300
Subject: [PATCH v2] mtd/mxc_nand: don't call mtd->{suspend,resume}
	explicitly
In-Reply-To: <4C41A6EA.8070501@eukrea.com>
References: <1276801147-4103-1-git-send-email-eric@eukrea.com>
	<1276801147-4103-2-git-send-email-eric@eukrea.com>
	<1276801147-4103-3-git-send-email-eric@eukrea.com>
	<1276801147-4103-4-git-send-email-eric@eukrea.com>
	<4C415AB5.9070705@eukrea.com>
	<1279351998.7515.0.camel@localhost.localdomain>
	<4C41A6EA.8070501@eukrea.com>
Message-ID: <1279379626.7515.5.camel@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-07-17 at 14:49 +0200, Eric B?nard wrote:
> Hi Artem,
> 
> Le 17/07/2010 09:33, Artem Bityutskiy a ?crit :
> > On Sat, 2010-07-17 at 09:24 +0200, Eric B?nard wrote:
> >> can you also pick this patch for mxc_nand ?
> >
> > It is in my tree already, and I sent a notification as well :-)
> >
> 
> OK, sorry, I didn't see the notification mail and only checked your 
> master branch, not the dunno branch where you applied this patch !

Yeah, I put to master only the stuff I understand and hence, can
sight-off. The rest goes to dunno - David then processes it.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
