From: afzal@ti.com (Mohammed, Afzal)
Date: Mon, 17 Sep 2012 08:06:07 +0000
Subject: [PATCH v9 3/3] ARM: OMAP2+: gpmc: minimal driver support
In-Reply-To: <alpine.DEB.2.00.1209121631440.17903@utopia.booyaka.com>
References: <cover.1347355380.git.afzal@ti.com>
 <35901c3137e42170066f3efb5026b0749ccdcbb5.1347355380.git.afzal@ti.com>
 <alpine.DEB.2.00.1209121631440.17903@utopia.booyaka.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9E4D92@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Wed, Sep 12, 2012 at 22:04:16, Paul Walmsley wrote:

> Two checkpatch warnings are added by this patch:

I did checkpatch earlier, but without --strict

> I've fixed them here in the obvious way.  But please make sure that all 
> your patches are clean with 'checkpatch.pl --strict'; saves us time and 
> frustration...

I am sorry for that, in future --strict will be part of my process

Perhaps it would be better to patch Documentation with a mention
of --strict for checkpatch

And seeing an unpleasant behavior with --strict, running
checkpatch over cached changes (for pre-commit hook) is
not making effect of --strict felt

Regards
Afzal
