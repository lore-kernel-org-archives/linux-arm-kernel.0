From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 31 Jan 2012 01:10:25 +0100
Subject: [GIT PULL] plat-nomadik timers for next
Message-ID: <1327968625-2322-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Arnd, Olof,

This is stuff for -next, i.e. not -rc:s, unless you find a
reason for.

It consists of Nomadik timer cleanups and modernization
which makes this timer code look proper. All has been
reviewed on LAKML and now needs to rotate in -next.

Yours,
Linus Walleij


The following changes since commit dcd6c92267155e70a94b3927bce681ce74b80d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git ux500-timers

Linus Walleij (3):
      ARM: plat-nomadik: get rid of global mtu base pointer
      ARM: plat-nomadik: handle clocking properly
      ARM: plat-nomadik: modernize MTU timer

 arch/arm/mach-nomadik/board-nhk8815.c      |    7 +----
 arch/arm/mach-nomadik/include/mach/setup.h |   19 ----------------
 arch/arm/mach-ux500/include/mach/setup.h   |    3 --
 arch/arm/mach-ux500/timer.c                |    7 +++--
 arch/arm/plat-nomadik/include/plat/mtu.h   |    4 +--
 arch/arm/plat-nomadik/timer.c              |   33 ++++++---------------------
 6 files changed, 15 insertions(+), 58 deletions(-)
 delete mode 100644 arch/arm/mach-nomadik/include/mach/setup.h
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPJzEMAAoJEEEQszewGV1zkEgQALdo2HDa+CDa1vL51/nRUJMX
hjBtSBmYpKh9j8D7hlLLZIcETGR+8mzSZGEjhuPE1eYQcYr+Xlb1xy0LTpMyjd4n
TCt1x2fI16JXbcLJXeToRm+5IsmqkldVZCYzdRKVCFbNsuNg6ZynYj6rv6WY0Wi9
EZROAGR2z1DFMIUtq4UE85FT9q/JhyZDHA4xdJ1TS9O7P34CQGzNrok1EnLwf1A6
EdDS7v9jsOhDZAyc2D6b9fNzlRvK03r+qhd5DV6/x8FPq2IVRn98WrZO39PDbHrt
rVuT/VW1gE57bK9o//sGt8F/38t8O05pfJyck4wE7jfsrd+YPjdaKVWSPKiW+Jr6
jndk2h1jyMU076UqmMhu87yeMWLsuUHMzwJrHtTFV/50jDdwnWu9u8lhANz8995b
9oQSYo8uwXQcH1HIl/jvXLlhsuUFpqchS1uq08egOlp9JYYhFhlPOmhKXxDNYwJz
l0vDwXeE+F9C+aH+vVvMRwGwKmCKOrfKw0nctDv2ymwnCW6z0Xcu8mfJzPkwzLzU
6/SYVyEM1FGkR5k68SS+mCAPe+CgHSWhnvIRv4Yy97rJ446EhDosgqOk2qQOkloK
LhzBXvULdlF1O+BLR8IQJ2oqGGskhhzRcxXeamjPDjw4xuMbN4OeAROU7QTmkbyF
ci67lAxXCaVKpHniSRNv
=v9KI
-----END PGP SIGNATURE-----
