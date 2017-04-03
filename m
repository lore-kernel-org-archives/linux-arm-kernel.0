From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Apr 2017 13:45:50 +0200
Subject: Updating sunxi tree in linux-next
In-Reply-To: <20170403095603.43cef189@canb.auug.org.au>
References: <20170331075729.gsfewphm3zd45vwt@lukather>
 <20170403095603.43cef189@canb.auug.org.au>
Message-ID: <20170403114550.wsubsqgacqdaaqkg@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Mon, Apr 03, 2017 at 09:56:12AM +1000, Stephen Rothwell wrote:
> Hi Maxime,
> 
> On Fri, 31 Mar 2017 09:57:29 +0200 Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> >
> > We've switched from my personal git tree for the Allwinner sunxi
> > development to a shared tree:
> > git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git
> > 
> > The branch to be included in linux-next will still be called
> > sunxi/for-next as it used to be, and it will still go through the
> > arm-soc tree to reach Linux.
> > 
> > However, I'll still have the patches for our DRM drivers on my
> > personal git repo:
> > git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git
> > 
> > Could you add the branch sunxi-drm/for-next to the list of branches
> > you merge?
> 
> OK, just so we are on the same page:
> 
> Currently I have:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git branch sunxi/for-next
> 
> merged after the drm tree.
> 
> You want:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git branch sunxi/for-next
> 
> merged after the arm-soc tree and
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git branch sunxi-drm/for-next
> 
> merged after the drm tree?

Yep, exactly.

> (I merge trees *after* the tree that is their upstream.)
> 
> Do you want to be the only contact for both trees?

Like Chen-Yu said, please add us both for sunxi/for-next

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170403/c6c0e22b/attachment.sig>
