From: horms@verge.net.au (Simon Horman)
Date: Fri, 19 Oct 2012 15:50:08 +0900
Subject: [GIT PULL] Renesas ARM-based SoC fixes for v3.7 #2
In-Reply-To: <1350629360-27438-1-git-send-email-horms@verge.net.au>
References: <1350629360-27438-1-git-send-email-horms@verge.net.au>
Message-ID: <20121019065008.GA27867@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 03:49:19PM +0900, Simon Horman wrote:
> Hi Olof, Hi Arnd,
> 
> please consider the following fix for the r8a7779 SoC for 3.6.

Same typo as last time: s/3.6/3.7/

> It resolves some more fallout from recent IOMEM() changes.
> 
> ----------------------------------------------------------------
> The following changes since commit 11f93576b0b50bf391ffafa544b85e541f5e59a5:
> 
>   ARM: shmobile: r8a7779: use __iomem pointers for MMIO (2012-10-16 08:58:56 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git fixes
> 
> for you to fetch changes up to ed7d132a634e7e4c3fa657363df5df39e7f768e4:
> 
>   ARM: shmobile: r8a7779: I/O address abuse cleanup (2012-10-19 15:39:38 +0900)
> 
> ----------------------------------------------------------------
> Kuninori Morimoto (1):
>       ARM: shmobile: r8a7779: I/O address abuse cleanup
> 
>  arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
