From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 1 Sep 2017 15:20:12 +0200
Subject: [GIT PULL] Allwinner DT changes for 4.14, take 3
In-Reply-To: <20170828092246.h66hjoqmv3r3kpes@flea.lan>
References: <20170828092246.h66hjoqmv3r3kpes@flea.lan>
Message-ID: <20170901132012.x2wqwaxdprsdnooj@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, Aug 28, 2017 at 11:22:46AM +0200, Maxime Ripard wrote:
> Hi,
> 
> Here is a late pull request for the 4.14 merge window.
> 
> Along with the fixes pull request I'm about to change, this should be
> our last pull request for the next release.

Since you merged the fixes that remove the EMAC nodes for 4.13
already, we really need to have that merged in 4.14, otherwise we'll
end up with a build breakage of the beelink device tree.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170901/40cc6a84/attachment.sig>
