From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 4 Oct 2018 21:37:27 +0200
Subject: linux-next: Signed-off-by missing for commits in the arm-soc tree
In-Reply-To: <20181003072140.7c18d772@canb.auug.org.au>
References: <20181003072140.7c18d772@canb.auug.org.au>
Message-ID: <20181004193727.qci3puitpxml26m5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wed, Oct 03, 2018 at 07:21:40AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   6eeb4180d4b9 ("ARM: dts: sunxi: h3-h5: Add Bananapi M2+ v1.2 device trees")
>   80c21c8c8b8d ("arm64: dts: allwinner: h5: Add device tree for Bananapi M2 Plus H5")
>   aa8fee415f46 ("ARM: dts: sun8i: h3: Split out non-SoC-specific parts of Bananapi M2 Plus")
>   db9fd9d13e30 ("ARM: dts: sun8i: h3: bpi-m2-plus: Fix address for external RGMII Ethernet PHY")
>   6c700289a3e8 ("ARM: dts: sun8i: h3-h5: ir register size should be the whole memory block")
> 
> are missing a Signed-off-by from their committer.

I just sent a new PR with the SoB this time (and I just learnt that
git rebase rewrites the committer...)

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181004/a1d0e8ec/attachment.sig>
