From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 20 Sep 2012 13:06:54 +0100
Subject: [PATCH v2 07/13] misc: Versatile Express config infrastructure
In-Reply-To: <201209191308.43676.arnd@arndb.de>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
 <1347977875-16855-8-git-send-email-pawel.moll@arm.com>
 <201209191308.43676.arnd@arndb.de>
Message-ID: <1348142814.11116.113.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-09-19 at 14:08 +0100, Arnd Bergmann wrote:
> > As it doesn't seem to be a "bus" any more, I left it in in misc for
> > now... It looks to me like there should be some kind of place for
> > "system/soc control" drivers. Or maybe there is, and I just missed
> > it?
> 
> We've discussed a generic system controller framework in the past,
> but it hasn't happened so far.  Dong Aisheng has posted a
> "syscon" driver a few times, and it could eventually merge with
> this one.

Yep, a generic framework for "random collection of stuff" would be
useful.

> For now, I'd suggest you put this driver into drivers/mfd together
> with the other part from your patch 8.

Do you mean - merge it into one file? I'd rather avoid that - the time
will come (and probably sooner than I would hope) when there will be a
new VE generation with some other "config bridge" instead of the
sysregs.

Pawe?
