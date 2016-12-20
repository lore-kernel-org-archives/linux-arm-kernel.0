From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Dec 2016 20:11:26 +0100
Subject: [PATCH 1/2] ASoC: sun4i-spdif: remove legacy dapm components
In-Reply-To: <20161220144914.30945-2-codekipper@gmail.com>
References: <20161220144914.30945-1-codekipper@gmail.com>
 <20161220144914.30945-2-codekipper@gmail.com>
Message-ID: <20161220191126.ozafu5cqvmqdsnn5@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2016 at 03:49:13PM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> The dapm components are now handled by the ALSA SoC SPDIF DIT driver
> so can be removed.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161220/8560510e/attachment.sig>
