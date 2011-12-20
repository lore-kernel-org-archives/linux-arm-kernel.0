From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Dec 2011 15:01:11 +0100
Subject: [GIT PULL] U300 updates for 3.3
Message-ID: <1324389671-17507-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi ARM-SoC Arnd, Olof,

This is the one v3.3 accumulated patch for U300, removing the
memory.h file, which is nice. Please pull it in, thanks!

The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:

  Linux 3.2-rc4 (2011-12-01 14:56:01 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git u300-for-arm-soc

Linus Walleij (1):
      ARM: u300: delete memory.h

 arch/arm/Kconfig                         |    1 -
 arch/arm/mach-u300/include/mach/memory.h |   19 -------------------
 arch/arm/mach-u300/u300.c                |    2 +-
 3 files changed, 1 insertions(+), 21 deletions(-)
 delete mode 100644 arch/arm/mach-u300/include/mach/memory.h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO8JQQAAoJEEEQszewGV1zpNYQAMmNygTGmgSfaqJbRfqDRyAM
DUT/GquVCCUhk8aXifguo65RuGW6Qe3+RovJcXMrMmWnkkRavnw9jNYZv+84JUg4
riH9v+alfagJz8ipzXugc4tvZKV8Qy9nO1ueJcsQjKk4YbClBtmxnR+dF3kocWmT
VBusY7BNEU+7FBAfxuR7S0+SEvwZYo58cMSswLCJkIxqbhMaYOOBA1bNReBPgLWP
lyVEdFLFsFNj1Ei9iIwpLOqRsB9bp2KYuIXMEfYBFFyTn/n+oaAaaKEwUdMc6qX1
KPWlt5+J7RS6ozNNfyRDaHQb04FlAXOHMnbIbjYAGpeuu2N8JMAMtydHWcdhAnIo
sXyf49TVQlZDwOXKf0OLCudYil6f15hYwUL155bsgtLuZVVD+WJsSOjS6IzAem5C
fL4Gm64Uy7HZPrIbvA3Sjfh4fOh17jQK/szkYN81bC47zQBFiRRNTnw6puboosRx
vd6plDoXbppj+JMxYS309xaMiKxrmKwBaddEhBMwoH+ftWFPgnvbetKEVb9p32kV
bn6eZ4DYJwjtiCdreiBjHVue+wysyBO2xiAqbp1Jxe5Q9kAPxhFRNDEqWlgcHJn9
v7s9mva8tJqoAq9/EjY1+RppJCuqAq0zdSHaekiT6UT4FgGrUma/F1LnjRWm7FXF
7K0eCKTS+XAX5pV41wtr
=8wtX
-----END PGP SIGNATURE-----
