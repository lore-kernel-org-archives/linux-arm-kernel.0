From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Dec 2011 15:13:04 +0100
Subject: [GIT PULL] Ux500 patches for 3.3, take two
Message-ID: <1324390384-17732-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi ARM-SoC, Arnd, Olof,

These are more ux500 patches for the 3.3 merge window, mainly removing
prototype silicon support and cleaning up stuff. They are closely
related to the three earlier patches sent for this merge window,
and done on the same branch, so it is based on top of the previous
pull request. (The series as a whole is available on the same branch,
based off v3.2-rc4.)

Please pull it in, yours
Linus Walleij

The following changes since commit 017beaa63bd8034b6c6c0f964a57f54973f59f17:

  ARM: ux500: update the MOP500 GPIO assignments (2011-12-12 09:48:31 +0100)

are available in the git repository at:
   git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git ux500-for-arm-soc

Linus Walleij (4):
      ARM: ux500: update ASIC detection for U5500
      ARM: ux500: update register files
      ARM: ux500: remove support for early silicon revisions
      ARM: ux500: fix the smp_twd clock calculation

Rabin Vincent (2):
      ARM: ux500: support DB8520
      ARM: ux500: register DB5500 PMU dynamically

 arch/arm/mach-ux500/board-mop500-sdi.c         |   54 +++----
 arch/arm/mach-ux500/clock.c                    |  207 ++++++------------------
 arch/arm/mach-ux500/cpu-db5500.c               |   41 +++---
 arch/arm/mach-ux500/cpu-db8500.c               |   30 +----
 arch/arm/mach-ux500/devices-db8500.c           |   10 --
 arch/arm/mach-ux500/id.c                       |    6 +-
 arch/arm/mach-ux500/include/mach/db5500-regs.h |    4 +
 arch/arm/mach-ux500/include/mach/db8500-regs.h |   20 +--
 arch/arm/mach-ux500/include/mach/devices.h     |    2 -
 arch/arm/mach-ux500/include/mach/hardware.h    |   10 +-
 arch/arm/mach-ux500/include/mach/id.h          |   24 +++
 11 files changed, 136 insertions(+), 272 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJO8JeFAAoJEEEQszewGV1zeQQQALR4lF9S55U0YtTLGSx4BZ25
Pzog1AoRM5Ji0k41Pelvh1QFbifSq3gqnnYTHv+nOIVvIEc+XS7XTTrIewAvzxsU
wMEYnEEG5c9ZJg1ZF02lNaYyIIdyiBYE8LwLtuwRIPwEkCkUj1UkCgw9fuabYV/q
4YAUgwXOgTgPDxoQYOJIwCFS7kA6owWG2eM/1dN9x93CZtd4JnTDbsV8Cg0j44/r
HBuggQRzOqnuxyzg924ypLYV7T9c0uH15vPqCXqj+W227P1mAIy0WDij8OgwDpDk
QjXabPrSrV7/HpN8tgT+doggcSbE2ydApLgMrQQBDn3s3ilwJXq9FqPFsEuD0Ann
qfterZwHuuKGE2FJdGH1hVf2g6JDEYVwNlLHBLk9MlzZaQH3vIq8V1Z6qh0RC1m7
gmqprbWvDk5r0PntUVbb7BXyPxZN9kBUgaBBatE9QIfZCN8P7PnmQhYJEqqa1mwI
2UoXVN9a/VHiueMNygzxaU0GbBTdeyDKAQ8+r2+GeV59/PZxWm8SkoBpYj4LBOnQ
amlDqvMpnqeZzqsMAzklYf97Ar6MZdyMeATUSwrphCEj9QnF6+v6if7dgwAwBHGe
hnxgxodkvbpuMs7zgcT6sCuLVaxp9ZqGlMvh+4rkfWylsWm6ROVWGVGnqisNw1Xo
fhz3+qFGHIRSf0OqQZUL
=iZaO
-----END PGP SIGNATURE-----
