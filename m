From: oss@buserror.net (Scott Wood)
Date: Wed, 8 Aug 2018 18:01:52 -0500
Subject: [v2, 1/6] powerpc/pm: Fix suspend=n in menuconfig for e500mc
 platforms.
In-Reply-To: <20180411063551.30368-1-ran.wang_1@nxp.com>
References: <20180411063551.30368-1-ran.wang_1@nxp.com>
Message-ID: <20180808230152.GA5459@home.buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 11, 2018 at 02:35:46PM +0800, Ran Wang wrote:
> Also, unselect FSL_PMC which is for older platfroms instead.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Changes in v2:
>   - no change
> 
>  arch/powerpc/Kconfig |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)

It's not "fixing" anything, but rather enabling something that was
previously unsupported -- and that should happen after the code that
adds support.

-Scott
