From: olof@lixom.net (Olof Johansson)
Date: Sun, 18 Jun 2017 20:32:58 -0700
Subject: [GIT PULL] clean-up for omap1 for v4.13
In-Reply-To: <594110d3.05159d0a.1eb5a.5f93SMTPIN_ADDED_BROKEN@mx.google.com>
References: <594110d3.05159d0a.1eb5a.5f93SMTPIN_ADDED_BROKEN@mx.google.com>
Message-ID: <20170619033258.GM30022@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 03:32:44AM -0700, Tony Lindgren wrote:
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
> 
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.13/omap1-signed
> 
> for you to fetch changes up to 764e4ef0a8871339eeddaf27ccc47aeeea28b974:
> 
>   ARM: OMAP1: Fix a typo in a comment line (2017-06-06 23:54:13 -0700)
> 
> ----------------------------------------------------------------
> A series of omap1 changes for issues found by Coccinelle.
> 
> ----------------------------------------------------------------
> Markus Elfring (5):
>       ARM: OMAP1: DMA: Improve a size determination in omap1_system_dma_init()
>       ARM: OMAP1: DMA: Delete an error message for a failed memory allocation in omap1_system_dma_init()
>       ARM: OMAP1: DMA: Delete an unnecessary return statement in omap1_show_dma_caps()
>       ARM: OMAP1: Delete an error message for a failed memory allocation in omap1_dm_timer_init()
>       ARM: OMAP1: Fix a typo in a comment line

Thanks, merged into next/soc.


-Olof
