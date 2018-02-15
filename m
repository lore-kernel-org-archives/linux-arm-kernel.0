From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 15 Feb 2018 10:08:38 +0100
Subject: [PATCH v2 0/2] Fix broken bananapi m2 devicetree/regulators
In-Reply-To: <20180214141025.22171-1-embed3d@gmail.com>
References: <20180214141025.22171-1-embed3d@gmail.com>
Message-ID: <20180215090838.fnenymzrejs6vhcf@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 03:10:23PM +0100, Philipp Rossak wrote:
> This patchseries fixes the bananapi m1 devicetree, to be able to boot again.
> The first two patches update/improve the devicetree and the last patch adds
> all missing regulators.
> 
> Regards,
> Philipp
> 
> Changes since v1:
> 	* squashed commit 1 and 3
> 	* fix wrong mmc regulator
> 
> Philipp Rossak (2):
>   arm: dts: sun6i: a31s: bpi-m2: improve pmic properties
>   arm: dts: sun6i: a31s: fix: bpi-m2: add missing regulators

Applied both.

I had to make a couple of changes though, in the commit title arm
should be uppercase, and the fix isn't needed.

I also added stable in Cc, since these patches have been there for
quite some time.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180215/6bebb158/attachment.sig>
