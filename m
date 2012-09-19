From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Sep 2012 13:08:43 +0000
Subject: [PATCH v2 07/13] misc: Versatile Express config infrastructure
In-Reply-To: <1347977875-16855-8-git-send-email-pawel.moll@arm.com>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
 <1347977875-16855-8-git-send-email-pawel.moll@arm.com>
Message-ID: <201209191308.43676.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 September 2012, Pawel Moll wrote:

> Hi Arnd,
> 
> As it doesn't seem to be a "bus" any more, I left it in in misc for
> now... It looks to me like there should be some kind of place for
> "system/soc control" drivers. Or maybe there is, and I just missed
> it?

We've discussed a generic system controller framework in the past,
but it hasn't happened so far.  Dong Aisheng has posted a
"syscon" driver a few times, and it could eventually merge with
this one.

For now, I'd suggest you put this driver into drivers/mfd together
with the other part from your patch 8.

	Arnd
