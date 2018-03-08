From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 8 Mar 2018 16:13:22 +0100
Subject: [PATCH 4/4] ARM: sunxi: mc-smp: Split out SoC-specific device
 node lookup sequence
In-Reply-To: <20180308150012.19045-5-wens@csie.org>
References: <20180308150012.19045-1-wens@csie.org>
 <20180308150012.19045-5-wens@csie.org>
Message-ID: <20180308151322.pz5p26r6bdyngxok@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 08, 2018 at 11:00:12PM +0800, Chen-Yu Tsai wrote:
> The multi-cluster SMP code maps the address spaces of several hardware
> control blocks. The device nodes for them are SoC-specific. To help with
> supporting other SoCs to re-use this code, these bits should be split
> out to a separate function tied to the enable-method string.
> 
> This patch splits out and groups the device node lookup sequence, and
> adds new data structures to have the newly created function tied to
> the enable method string. This structure can also be used to encode
> other differences between the SoCs.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180308/09c92a40/attachment.sig>
