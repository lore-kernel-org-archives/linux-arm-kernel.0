From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 Sep 2016 11:29:51 +0300
Subject: [PATCH v5 3/3] ASoC: sun4i-codec: Add custom regmap configs
In-Reply-To: <20160922071313.12891-4-dannym@scratchpost.org>
References: <20160922071313.12891-1-dannym@scratchpost.org>
 <20160922071313.12891-4-dannym@scratchpost.org>
Message-ID: <20160922082951.GM8719@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 22, 2016 at 09:13:13AM +0200, Danny Milosavljevic wrote:
> The A20 has a few extra registers that the A10 doesn't have.
> Therefore, use different regmaps for A10 as compared to A20.
> 
> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>

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
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160922/630d1516/attachment.sig>
