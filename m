From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 26 Sep 2012 18:08:12 +0200
Subject: [PATCH V5] Add support for Aurora L2 Cache Controller
In-Reply-To: <1348675370-16359-1-git-send-email-gregory.clement@free-electrons.com>
References: <1348675370-16359-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <5063286C.9070502@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Changelog:
> V4 -> V5:
> - Rebased L2 pach set onto v3.6-rc7.
> - The header file cache-aurora-l2.h was co-located with its only user:
>   moved from arch/arm/include/asm/hardware/ to arch/arm/mm/.
> - Removed additional unnecessary blank lines in cache-l2x0.c.
> 
Russell,

will you take the all series from the git repository ? As the
last patches have been already acked-by Arnd and were initially pulled
by Jason Cooper, I think there should be no problem to get the whole
series.

Now if you only want to take the first three patches, will you pull
them from the git repository or do you prefer that I submit them
through your patch system?

Thanks,

Gregory

> 
> The git branch aurora-L2-cache-ctrl is visible at
> https://github.com/MISL-EBU-System-SW/mainline-public.git
