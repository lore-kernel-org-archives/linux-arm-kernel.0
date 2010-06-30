From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Thu, 1 Jul 2010 01:11:31 +0400
Subject: [GIT PULL v2] Some Cavium CNS3xxx updates for 2.6.36
In-Reply-To: <20100608170030.GA26992@oksana.dev.rtsoft.ru>
References: <20100608170030.GA26992@oksana.dev.rtsoft.ru>
Message-ID: <20100630211131.GA29737@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Tue, Jun 08, 2010 at 09:00:30PM +0400, Anton Vorontsov wrote:
> The main reason for the v2 is, obviously, the defconfigs situation.
> I dropped the defconfig update in this pull request.
> 
> There are also few improvements as suggested by by Ben Dooks and
> Sergei Shtylyov, plus there is no longer the ugly
> "../../../drivers/mmc/host/sdhci.h" include anymore.
> 
> As usual, I'm posting the updated patches as well.
> 
> The following changes since commit 9dda696f0de87a2e5cfabb147e28c76b7d3c6846:
>   Linus Torvalds (1):
>         Merge branch 'release' of git://git.kernel.org/.../aegl/linux-2.6
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/cbou/linux-cns3xxx.git master

I noticed that you pulled some other trees, but not this one.
Is there any particular reason, or it's in the queue?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
