From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 14 Oct 2013 15:02:44 -0700
Subject: [GIT PULL] Second Round of Renesas ARM based SoC board updates
 for v3.13
In-Reply-To: <cover.1381299817.git.horms+renesas@verge.net.au> (Simon Horman's
 message of "Wed, 9 Oct 2013 15:50:43 +0900")
References: <cover.1381299817.git.horms+renesas@verge.net.au>
Message-ID: <874n8j5x4r.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon Horman <horms+renesas@verge.net.au> writes:

> Hi Kevin, Olof and Arnd,
>
> please consider this second round of Renesas ARM based SoC board updates
> for v3.13.
>
> This pull request is based on a merge of renesas-soc2-for-v3.13 into
> renesas-boards-for-v3.13. You have already pulled renesas-boards-for-v3.13
> and I am sending a pull request for renesas-soc2-for-v3.13 today. The
> reason for this merge is to supply SoC code that is needed by board code in
> this series. In particular the r7s72100 SoC code for the Genmai board.
>
>
> The following changes since commit 661a7335c4e47726df1e7264580209847509569a:
>
>   Merge branch 'heads/soc2' into boards2-base (2013-10-08 10:01:47 +0900)
>
> are available in the git repository at:
>
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards2-for-v3.13
>
> for you to fetch changes up to 7d4bde88e1135c4a3106b79650d3b85335f35717:
>
>   ARM: shmobile: marzen: enable INTC IRQ (2013-10-08 10:02:22 +0900)
>
> ----------------------------------------------------------------
> Second Round of Renesas ARM based SoC board updates for v3.13
>
> * Enable INTC IRQ on marzen board
> * Enable SMSC ethernet on reference board code for bockw
> * Enable DMA for SDHI0 on marzen and bockw boards
> * Enable DMA for MMCIF on ape6evm board
> * Enable SMP and arch timers on Koelsh board
> * Rework kzm9d make reference board code multiplatform
> * Use a common DTB for kzm9d reference and non-reference
> * Add Genmai board

Thanks, pulled into next/boards.

Kevin
