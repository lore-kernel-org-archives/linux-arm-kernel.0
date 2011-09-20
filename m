From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Sep 2011 22:10:08 +0200
Subject: [GIT PULL] davinci fixes for v3.2 merge window
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB59302575A0DD6@dbde02.ent.ti.com>
References: <B85A65D85D7EB246BE421B3FB0FBB59302575A0DD6@dbde02.ent.ti.com>
Message-ID: <201109202210.08714.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 September 2011, Nori, Sekhar wrote:
> Please pull the following two fixes for the v3.2
> merge window. They are not applicable to stable
> tree and hence the stable tag has not been added.
> 
> Thanks,
> Sekhar
> 
> The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:
>   Linus Torvalds (1):
>         Linux 3.1-rc6
> 
> are available in the git repository at:
> 
>   git://gitorious.org/linux-davinci/linux-davinci.git v3.2/fixes
> 
> Ido Yariv (1):
>       ARM: davinci: Explicitly set channel controllers' default queues
> 
> Thomas Meyer (1):
>       ARM: davinci: edma: use kzalloc()

Hi Sekhar,

Looking at the patches, they seem to be more of the cleanup category,
so I think I'd apply them to the next/cleanup branch instead of
the next/fixes branch. Does that make sense?

	Arnd
