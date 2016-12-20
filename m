From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 20 Dec 2016 20:12:46 +0100
Subject: [PATCH 2/2] ASoC: sun4i-spdif: Add quirks to the spdif driver
In-Reply-To: <20161220144914.30945-3-codekipper@gmail.com>
References: <20161220144914.30945-1-codekipper@gmail.com>
 <20161220144914.30945-3-codekipper@gmail.com>
Message-ID: <20161220191246.7fcvfovvvttdntn3@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2016 at 03:49:14PM +0100, codekipper at gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> It has been seen that some newer SoCs have a different TX FIFO
> address and we already have the difference with the A31 requiring
> a reset. Add a quirks structure so that these can be managed
> easily.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161220/f7369346/attachment.sig>
