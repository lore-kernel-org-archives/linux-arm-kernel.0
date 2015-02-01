From: olof@lixom.net (Olof Johansson)
Date: Sat, 31 Jan 2015 17:30:32 -0800
Subject: [GIT PULL] Third Round of Renesas ARM Based SoC Fixes for v3.19
In-Reply-To: <cover.1422577690.git.horms+renesas@verge.net.au>
References: <cover.1422577690.git.horms+renesas@verge.net.au>
Message-ID: <CAOesGMjNhdiaO0-qhD03EkPt2rjQa46RFnQFXccmph67VkZt8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon,


On Thu, Jan 29, 2015 at 4:45 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
>
> Please consider these third round of Renesas ARM based SoC fixes for v3.19.
>
> This pull request is based on the previous round of
> such requests, tagged as renesas-soc-fixes2-for-v3.19,
> which I have already sent a pull-request for.
>
>
> This fixes a regression in the r8a7790 and r8a73a4 SoCs due to
> 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq domain.")
> which was included in v3.19-rc1.
>
> This pull-request is targeted at v3.19. r8a7790 patch in this pull-request
> conflicts with the patch "ARM: shmobile: lager: Remove legacy board
> support" which was included in the pull request "Renesas ARM Based SoC
> Lager Board Removal for v3.20" which you have pulled for v3.20. The
> conflict occurs because board-lager.c is removed in that patch whereas
> this series updates that file.
>
> In other words, this series fixes board code for the lager/r8a7790 for v3.19
> which is scheduled for removal in v3.20.
>
>
> The following changes since commit f469cde20a7ee342070b4a459b6fce469a3186db:
>
>   ARM: shmobile: r8a7779: Instantiate GIC from C board code in legacy builds (2015-01-17 09:28:41 +0900)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-fixes3-for-v3.19
>
> for you to fetch changes up to 77cf5166f21c3b73b04571311dc89a327424f594:
>
>   ARM: shmobile: r8a7790: Instantiate GIC from C board code in legacy builds (2015-01-29 17:52:38 +0900)
>
> ----------------------------------------------------------------
> Third Round of Renesas ARM Based SoC Fixes for v3.19
>
> * Instantiate GIC from C board code in legacy builds on r8a7790 and r8a73a4
>
> ----------------------------------------------------------------
> Magnus Damm (2):
>       ARM: shmobile: r8a73a4: Instantiate GIC from C board code in legacy builds
>       ARM: shmobile: r8a7790: Instantiate GIC from C board code in legacy builds

This is the third branch you've sent us with the same type of fixes.
Was there a reason for why you couldn't have prepared all of them at
the same time once it was known to be a systematic problem?


-Olof
