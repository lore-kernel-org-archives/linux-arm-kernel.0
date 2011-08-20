From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 20 Aug 2011 09:41:35 +0900
Subject: [PATCH v2] ARM: S3C64XX: Use module identification for Craggamore
	system builds
In-Reply-To: <20110819220210.GB3772@opensource.wolfsonmicro.com>
References: <1313498575-13465-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<004101cc5e77$3ad49030$b07db090$%kim@samsung.com>
	<20110819220210.GB3772@opensource.wolfsonmicro.com>
Message-ID: <007401cc5ed1$ea70ab50$bf5201f0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote:
> 
> On Fri, Aug 19, 2011 at 10:52:26PM +0900, Kukjin Kim wrote:
> > Mark Brown wrote:
> 
Hi Mark,

> Please delete unneeded context from mails, it makes it much easier to
> find the reply.
> 
Yes, I did. As you know, 'git am' can handle it.

> > > -#include <sound/wm8996.h>
> 
> > Hmm...Why is this <sound/wm8915.h> in my tree?
> 
This was my question when I found conflict during applying...

> This was waiting for cross tree issues to settle down in the merge
> window before being applied - it's in -rc2 which appeared last week or
> you can pull the individual change from:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git
wm8996-rename

Yes, so I applied this in my tree after rebasing -rc2 :)

You can find this in my for-next and next-samsung-devel.
If any problems, please let me know.

Have a nice day.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
