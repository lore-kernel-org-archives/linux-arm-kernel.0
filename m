From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Jul 2017 08:35:30 +0200
Subject: [PATCH] ASoC: sun8i-codec: constify snd_soc_dai_ops structure
In-Reply-To: <20170713055223.GA18940@embeddedgus>
References: <20170713055223.GA18940@embeddedgus>
Message-ID: <20170713063530.mheqk6kymzrxfbud@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 12:52:23AM -0500, Gustavo A. R. Silva wrote:
> This structure is only stored in the ops field of a snd_soc_dai_driver
> structure. That field is declared const, so snd_soc_dai_ops structures
> that have this property can be declared as const also.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170713/6e90b6d9/attachment.sig>
