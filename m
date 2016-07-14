From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Jul 2016 15:24:54 +0200
Subject: [GIT PULL] Ux500 cleanups from Arnd
In-Reply-To: <CACRpkdYv8iT1gry8X+27Nj5w5_M38DVQ0ws-VKMf_fFrb2sP2Q@mail.gmail.com>
References: <CACRpkdYv8iT1gry8X+27Nj5w5_M38DVQ0ws-VKMf_fFrb2sP2Q@mail.gmail.com>
Message-ID: <6775863.Wjn8sn0gMr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 12, 2016 11:29:41 AM CEST Linus Walleij wrote:
> This is a set of cleanups for the Ux500 that reduce the number
> of machine-local files and boardfile-type data for regulators
> and ASoC.

I never really though about where to apply them, and ended up
putting this in next/drivers rather than next/cleanup,
since all the additions are in drivers, and we just remove
code from arch/arm here.

Thanks a lot for your testing and handling of the pull request!

	Arnd
