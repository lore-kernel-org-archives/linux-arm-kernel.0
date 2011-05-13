From: eballetbo@gmail.com (=?UTF-8?Q?Enric_Balletb=C3=B2_i_Serra?=)
Date: Fri, 13 May 2011 09:27:18 +0200
Subject: [RESEND PATCH 0/4] omap: merge IGEP v2 and v3
In-Reply-To: <cover.1305235542.git.mike@compulab.co.il>
References: <cover.1305235542.git.mike@compulab.co.il>
Message-ID: <BANLkTi=UpaA6vqxepUCMdi-BVWZxwTuRxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

2011/5/12 Mike Rapoport <mike@compulab.co.il>:
> Hi Tony,
>
> I'm resending this with the correct arm-linux mailing list cc'ed..
> Just discard the first set, sorry for the noise...
>
> This is yet another attempt to reduce code duplication in the board files :)
> Only build tested, since I don't have the hardware, so I belive an Ack from
> Enric is required.

Against which tree is based your work ?

Cheers,
  Enric

>
> Mike Rapoport (4):
> ?omap: igep0020: name refactoring for future merge with IGEP3
> ?omap: igep0020: minor refactoring
> ?omap: igep0020: add support for IGEP3
> ?omap: drop board-igep0030.c
>
> ?arch/arm/mach-omap2/Kconfig ? ? ? ? ?| ? ?1 +
> ?arch/arm/mach-omap2/Makefile ? ? ? ? | ? ?2 -
> ?arch/arm/mach-omap2/board-igep0020.c | ?286 +++++++++++++---------
> ?arch/arm/mach-omap2/board-igep0030.c | ?438 ----------------------------------
> ?4 files changed, 174 insertions(+), 553 deletions(-)
> ?delete mode 100644 arch/arm/mach-omap2/board-igep0030.c
>
> --
> 1.7.3.1
>
>
