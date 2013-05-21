From: olof@lixom.net (Olof Johansson)
Date: Mon, 20 May 2013 23:44:13 -0700
Subject: [GIT PULL] ARM: mvebu: fixes for v3.10 (round 2)
In-Reply-To: <20130520195135.GH31290@titan.lakedaemon.net>
References: <20130520195135.GH31290@titan.lakedaemon.net>
Message-ID: <20130521064413.GF20453@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 03:51:35PM -0400, Jason Cooper wrote:
> 
> The following changes since commit 00ed4a0bd964555fe9276f2299564c384d50ae7d:
> 
>   ARM: mvebu: Add a ranges entry to translate devbus childs (2013-05-13 16:23:47 +0000)
> 
> are available in the git repository at:
> 
>   git://git.infradead.org/users/jcooper/linux.git tags/fixes-3.10-2
> 
> for you to fetch changes up to 489e138eec96f529c5e8d4cd3ea45882ecdbf5ca:
> 
>   ARM: dts: mvebu: Fix wrong the address reg value for the L2-cache node (2013-05-20 17:44:54 +0000)

Pulled, thanks.

> 
> ----------------------------------------------------------------
> mvebu fixes for v3.10 (round 2)
> 
>  - mvebu (and orion SoCs)
>     - remove init_dma_coherent_pool_size()
> 
>  - mvebu
>     - fix ranges DT property

We've seen two of these now. Can someone please make a sweep and make sure
there are no more of these pending?


Thanks,

-Olof
