From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Nov 2014 18:14:35 +0000
Subject: [PATCH] ASoC: rt5631: Fixing compilation warning when DT is
 disabled
In-Reply-To: <F186754307084FE3B13FB03E93EF318A@sisodomain.com>
References: <1416828162-8216-1-git-send-email-krishna.md@samsung.com>
 <20141124170409.GF7712@sirena.org.uk>
 <F186754307084FE3B13FB03E93EF318A@sisodomain.com>
Message-ID: <20141126181435.GO7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 02:26:07PM +0530, D Krishna Mohan wrote:

> Following your suggestion I have sent a patch
> (187024b36c635bd454c1b1587b58c9439d3a46ad on your git, branch: rt5631 )
> using ifdef which you have already applied.
> Since there are more suggestion asking for second (__maybe_unused) method, I
> have sent another patch for which below is the link.

> You may be applying the second patch on the already applied first patch. so
> I request you to apply only second patch in place of first and abandon first
> patch.

Once something is applied in git you should always send further patches
as incrmental updates to that, this is much easier to manage and avoids
any potential confusion to other people looking at the tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141126/4e81e6db/attachment.sig>
