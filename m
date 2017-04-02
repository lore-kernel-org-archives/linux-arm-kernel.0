From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 3 Apr 2017 09:56:12 +1000
Subject: Updating sunxi tree in linux-next
In-Reply-To: <20170331075729.gsfewphm3zd45vwt@lukather>
References: <20170331075729.gsfewphm3zd45vwt@lukather>
Message-ID: <20170403095603.43cef189@canb.auug.org.au>
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

OK, just so we are on the same page:

Currently I have:

git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git branch sunxi/for-next

merged after the drm tree.

You want:

git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git branch sunxi/for-next

merged after the arm-soc tree and

git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git branch sunxi-drm/for-next

merged after the drm tree?

(I merge trees *after* the tree that is their upstream.)

Do you want to be the only contact for both trees?
-- 
Cheers,
Stephen Rothwell
