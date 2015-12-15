From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 Dec 2015 17:49:34 +0100
Subject: [GIT PULL] RealView defconfig updates
In-Reply-To: <CACRpkdbpOs24tx6pmPGaetDqu-VeD+pkUDb7BCw7n+KKUJP_oQ@mail.gmail.com>
References: <CACRpkdbpOs24tx6pmPGaetDqu-VeD+pkUDb7BCw7n+KKUJP_oQ@mail.gmail.com>
Message-ID: <1800981.2DlpbeHf85@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 December 2015 14:19:48 Linus Walleij wrote:
> Here are some updates to the RealView defconfigs, that make the
> system modern and testable. Mostly stuff that should have been
> enabled ages ago.
> 
> Whether it should go directly to the -rc:s or next merge window
> is up to the ARM SoC maintainers.
> 
> Please pull it it!

I've cherry-picked the patches into the next/defconfig branch for 4.5
now, to avoid backmerging -rc4 into the -rc3 based branch.

Thanks,

	Arnd
