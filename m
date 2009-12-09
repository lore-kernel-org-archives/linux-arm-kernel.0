From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 09 Dec 2009 10:39:34 +0000
Subject: [GIT PULL] Patches for 2.6.33-rc1
In-Reply-To: <1260354044.19669.1267.camel@localhost>
References: <1260353349.13499.4.camel@pc1117.cambridge.arm.com>
	<1260354044.19669.1267.camel@localhost>
Message-ID: <1260355174.13499.8.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-12-09 at 10:20 +0000, Artem Bityutskiy wrote:
> It is so much helpful when people add proper prefixes to patches, like
> ARM or something. I wander, do we have a requirement for this somewhere?
> But please, consider doing this, this makes it easier surfing git-log or
> gitk info.

It would be useful, indeed, so I haven't seen an official statement from
Russell on this (and I usually run gitk on specific directories). 

Traditionally we used the patch system which was adding a prefix but
since it cannot cope with a different author from the submitter, I just
use Git these days (I don't mind either way).

-- 
Catalin
