From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Mar 2017 09:57:29 +0200
Subject: Updating sunxi tree in linux-next
Message-ID: <20170331075729.gsfewphm3zd45vwt@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

We've switched from my personal git tree for the Allwinner sunxi
development to a shared tree:
git://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git

The branch to be included in linux-next will still be called
sunxi/for-next as it used to be, and it will still go through the
arm-soc tree to reach Linux.

However, I'll still have the patches for our DRM drivers on my
personal git repo:
git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git

Could you add the branch sunxi-drm/for-next to the list of branches
you merge?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170331/bff2dc25/attachment.sig>
