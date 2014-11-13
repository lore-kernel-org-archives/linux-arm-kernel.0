From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 13 Nov 2014 21:50:22 +0300
Subject: [GIT PULL] Third Round of Renesas ARM Based Soc Updates for v3.19
In-Reply-To: <cover.1415841454.git.horms+renesas@verge.net.au>
References: <cover.1415841454.git.horms+renesas@verge.net.au>
Message-ID: <5464FD6E.1090404@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/13/2014 04:20 AM, Simon Horman wrote:

> Hi Olof, Hi Kevin, Hi Arnd,

> Please consider these third round of Renesas ARM based soc updates for v3.19.

> This pull request is based on the previous round of
> such requests, tagged as renesas-soc2-for-v3.19,
> which I have already sent a pull-request for.

> This pull request is based on the previous round of
> such requests, tagged as renesas-soc2-for-v3.19,
> which I have already sent a pull-request for.

    OK, but we've got it the first time. :-)

> Please note that "ARM: shmobile: always build rcar setup for armv7"
> corrects a build failure in allmodconfig caused by "ARM: shmobile:
> rcar-gen2: Add CA7 arch_timer initialization for r8a7794" which
> is included in the first round of Renesas ARM Based SoC Soc Updates for
> v3.19, tagged as renesas-soc2-for-v3.19, which I have previously sent
> a pull-request for.

    This is a third time you're repeating that. :-)

> To be clear, this pull request is based on renesas-soc2-for-v3.19 which
> is in turn based on renesas-soc2-for-v3.19.

    Based on itself? :-)

> The following changes since commit 950a3f0e7dd32c372c9957d5c050b08de7ec9e56:

>    ARM: shmobile: Enable PCI domains for R-Car Gen2 devices (2014-11-05 14:50:17 +0900)

> are available in the git repository at:

>    git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc3-for-v3.19

> for you to fetch changes up to e3d163329753b3b473f40c9be71561ed8eb98aea:

>    ARM: shmobile: always build rcar setup for armv7 (2014-11-12 18:14:42 +0900)

> ----------------------------------------------------------------
> Third Round of Renesas ARM Based Soc Updates for v3.19

> * Always build rcar setup for armv7
>    - Fixes allmodconfig build fauilre caused by

    Failure.

>      "ARM: shmobile: always build rcar setup for armv7"

    Caused by itself? :-)

> * Add restart callback to sh73a0

> ----------------------------------------------------------------
> Arnd Bergmann (1):
>        ARM: shmobile: always build rcar setup for armv7

> Geert Uytterhoeven (1):
>        ARM: shmobile: sh73a0: Add restart callback

>   arch/arm/mach-shmobile/Makefile       | 1 +
>   arch/arm/mach-shmobile/setup-sh73a0.c | 8 ++++++++
>   2 files changed, 9 insertions(+)

WBR, Sergei
