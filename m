From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Aug 2012 12:30:24 +0000
Subject: [GIT PULL] Ux500 ASIC ID patches
In-Reply-To: <CACRpkdZ1+vjrTQC9-M9icO7p9POg-zcR_gUpkyemF4da3jny2w@mail.gmail.com>
References: <CACRpkdZ1+vjrTQC9-M9icO7p9POg-zcR_gUpkyemF4da3jny2w@mail.gmail.com>
Message-ID: <201208151230.24523.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 13 August 2012, Linus Walleij wrote:
> could you please pull the following patch set into ARM SoC as a first
> step for the
> next merge window. This cleans up, updates and structure the use of some ASIC ID
> detection macros so they are understandable and consistent.
> 
> The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:
> 
>   Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git ux500-core

Pulled, thanks!

I think it would be nice if you could move to using signed tags in
the future, and include the text you want to see in the merge
commit in that tag.

	Arnd
