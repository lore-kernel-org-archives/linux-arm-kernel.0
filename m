From: olof@lixom.net (Olof Johansson)
Date: Mon, 12 Jan 2015 14:37:28 -0800
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v3.20
In-Reply-To: <cover.1419810196.git.horms+renesas@verge.net.au>
References: <cover.1419810196.git.horms+renesas@verge.net.au>
Message-ID: <20150112223728.GK22090@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Mon, Dec 29, 2014 at 10:47:06AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC updates for v3.20.
> 
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v3.20
> 
> for you to fetch changes up to 39695882d3d642a73bca551e682426e4e3bcd158:
> 
>   ARM: shmobile: r8a73a4: Multiplatform support (2014-12-21 17:11:22 +0900)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Updates for v3.20
> 
> * Multiplatform support for r8a73a4
> * No TWD setup in C for Multiplatform on r8a7779
> * Fix is_e2 warning in generic R-Car Gen2 SoC setup code
> * Add missing Add missing legacy INTCA0 clock for irqpin module on sh73a0
> 
> ----------------------------------------------------------------
> Geert Uytterhoeven (1):
>       ARM: shmobile: sh73a0 legacy/reference: Add missing INTCA0 clock for irqpin module
> 
> Magnus Damm (2):
>       ARM: shmobile: Fix is_e2 warning
>       ARM: shmobile: r8a7779: No TWD setup in C for Multiplatform
> 
> Ulrich Hecht (1):
>       ARM: shmobile: r8a73a4: Multiplatform support


This branch is a little odd. There are several fixes in here, but it's grouped
as an SoC branch. I can see the multiplatform patch belonging here, but it
seems that the three other patches could go in a fixes-non-critical branch.

Anyway, I've merged this into next/soc now, but please try to keep some of
these a little better sorted going forward.

Thanks,

-Olof
