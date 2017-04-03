From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 4 Apr 2017 07:40:58 +1000
Subject: Updating sunxi tree in linux-next
In-Reply-To: <20170331075729.gsfewphm3zd45vwt@lukather>
References: <20170331075729.gsfewphm3zd45vwt@lukather>
Message-ID: <20170404074049.542a0e9c@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Fri, 31 Mar 2017 09:57:29 +0200 Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
>
> We've switched from my personal git tree for the Allwinner sunxi
> development to a shared tree:
> git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
> 
> The branch to be included in linux-next will still be called
> sunxi/for-next as it used to be, and it will still go through the
> arm-soc tree to reach Linux.
> 
> However, I'll still have the patches for our DRM drivers on my
> personal git repo:
> git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git
> 
> Could you add the branch sunxi-drm/for-next to the list of branches
> you merge?

Added and changed from today.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window. 

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell 
sfr at canb.auug.org.au
