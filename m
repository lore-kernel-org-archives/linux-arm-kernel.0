From: olof@lixom.net (Olof Johansson)
Date: Sat, 12 Jul 2014 09:37:49 -0700
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC soc-cleanup
 Updates for v3.17
In-Reply-To: <cover.1404173049.git.horms+renesas@verge.net.au>
References: <cover.1404173049.git.horms+renesas@verge.net.au>
Message-ID: <20140712163749.GD3954@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 09:28:37AM +0900, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Second Round of Renesas ARM Based SoC soc-cleanup Updates for v3.17.
> 
> This pull request is based on the previous round of
> such requests, tagged as renesas-soc-cleanup-for-v3.17,
> which I have already sent a pull-request for.
> 
> This conflicts with other changes made to pm-r8a7790.c in the soc branch
> of the renesas tree. A resolution can be found in the
> renesas-next-v3.16-rc1-20140628 tag of the next branch of that tree.
> 
> In short, the resulting includes should be:
> 
> #include <linux/kernel.h>
> #include <linux/smp.h>
> #include <asm/io.h>
> #include "common.h"
> #include "pm-rcar.h"
> #include "r8a7790.h"
> 
> 
> The following changes since commit d83fa4c9c27c4d8612e39e99506b5420fa05b58b:
> 
>   ARM: shmobile: Remove unused r8a7790_init_early() (2014-06-17 19:50:35 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-soc-cleanup2-for-v3.17
> 
> for you to fetch changes up to 113522ee3034427472bcb4b8665833719809b31a:
> 
>   ARM: shmobile: Move sh7372.h (2014-06-25 16:50:00 +0900)
> 
> ----------------------------------------------------------------
> Second Round of Renesas ARM Based SoC soc-cleanup Updates for v3.17
> 
> * Move SOC-specific headers out of mach directory.
>   This is part of a multi-stage effort to move headers
>   out of that directory.

Merged, but I didn't notice any conflict here. I might have resolved it
in the past already.


-Olof
