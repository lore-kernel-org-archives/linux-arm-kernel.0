From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 11 Sep 2014 23:16:01 +0200
Subject: [PATCH 7/7] dmaengine: sun6i: Remove obsolete clk muxing code
In-Reply-To: <1410000448-9999-8-git-send-email-wens@csie.org>
References: <1410000448-9999-1-git-send-email-wens@csie.org>
 <1410000448-9999-8-git-send-email-wens@csie.org>
Message-ID: <20140911211601.GO31276@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 06, 2014 at 06:47:28PM +0800, Chen-Yu Tsai wrote:
> The sun6i DMA controller requires the AHB1 bus clock to be
> clocked from PLL6. This was originally done by the dmaengine
> driver during probe time. The AHB1 clock driver has since been
> unified, so the original code does not work.
> 
> Remove the clk muxing code, and replace it with DT clk default
> properties.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140911/070a48b6/attachment.sig>
