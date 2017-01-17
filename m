From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jan 2017 17:41:11 +0100
Subject: [PATCH v2 01/10] ASoC: sun4i-i2s: Increase DMA max burst to 8
In-Reply-To: <20170117140230.23142-2-mylene.josserand@free-electrons.com>
References: <20170117140230.23142-1-mylene.josserand@free-electrons.com>
 <20170117140230.23142-2-mylene.josserand@free-electrons.com>
Message-ID: <20170117164111.76mefaj32fy64f7o@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2017 at 03:02:21PM +0100, Myl?ne Josserand wrote:
> As done previously for sun4i-codec, the DMA maxburst of 4
> is not supported by every SoCs so the DMA controller engine
> returns "unsupported value".
> 
> As a maxburst of 8 is supported by all variants, this patch
> increases it to 8.
> 
> For more details, see commit from Chen-Yu Tsai:
> commit 730e2dd0cbc7 ("ASoC: sun4i-codec: Increase DMA max burst to 8")

Those details could have been included directly in the commit log.

Otherwise,
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/04d60086/attachment.sig>
