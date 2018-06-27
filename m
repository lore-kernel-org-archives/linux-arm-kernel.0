From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 27 Jun 2018 20:37:21 +0200
Subject: [PATCH v2 0/7] Allwinner A64 DE2 CCU support with dedicated DE2
 bus driver
In-Reply-To: <20180622122615.55836-1-icenowy@aosc.io>
References: <20180622122615.55836-1-icenowy@aosc.io>
Message-ID: <20180627183721.jmmsmp3u3mq4drvb@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2018 at 08:26:08PM +0800, Icenowy Zheng wrote:
> This patchset tries to implement the Allwinner A64 DE2 as a bus driver,
> in order to model the fact that the SRAM claim controls the access to
> the whole DE2 memory space.
> 
> PATCH 1 and PATCH 4 are for the CCU part.
> 
> PATCH 2 is the device tree binding for the A64 DE2 bus, and PATCH 3
> implements the bus driver.
> 
> PATCH 5 adds the DE2 CCU device tree node, with the DE2 bus node.
> 
> PATCH 6 and 7 are HDMI simplefb patches for A64. They're present as a
> test to this patchset.

Applied all the patches with the minor modifications Chen-Yu and I
suggested.

The threading was broken on your serie though, so you probably want to
check your git configuration.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180627/df33d2e0/attachment.sig>
