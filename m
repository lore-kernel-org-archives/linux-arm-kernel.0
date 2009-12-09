From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 09 Dec 2009 12:20:44 +0200
Subject: [GIT PULL] Patches for 2.6.33-rc1
In-Reply-To: <1260353349.13499.4.camel@pc1117.cambridge.arm.com>
References: <1260353349.13499.4.camel@pc1117.cambridge.arm.com>
Message-ID: <1260354044.19669.1267.camel@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2009-12-09 at 10:09 +0000, Catalin Marinas wrote:
> Hi Russell,
> 
> There are some patches which were not pulled yet and it would be nice if
> they get in during this merging window. Two of them are bug-fixes and
> the other is the earlyprintk support which many people find useful.
> 
> My for-rmk branch was rebased to 2.6.32 to check what was already merged
> but I can rebase it something earlier if you want.
> 
> Thanks.
> 
> 
> The following changes since commit 22763c5cf3690a681551162c15d34d935308c8d7:
>   Linus Torvalds (1):
>         Linux 2.6.32
> 
> are available in the git repository at:
> 
>   git://linux-arm.org/linux-2.6.git for-rmk
> 
> Catalin Marinas (2):
>       Add an earlyprintk debug console
>       RealView: Fix typo in the Kconfig enabling SPARSEMEM for RealView/PBX
> 
> Varun Swara (1):
>       Do not allow the probing of the local timer

It is so much helpful when people add proper prefixes to patches, like
ARM or something. I wander, do we have a requirement for this somewhere?
But please, consider doing this, this makes it easier surfing git-log or
gitk info.

-- 
Best Regards,
Artem Bityutskiy (????? ????????)
