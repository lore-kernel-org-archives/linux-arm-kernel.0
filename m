From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 18 Sep 2016 22:17:47 +0200
Subject: [PATCH v4 2/3] ASoC: rename some sun7i-only registers
In-Reply-To: <20160915163630.18026-3-dannym@scratchpost.org>
References: <20160915163630.18026-1-dannym@scratchpost.org>
 <20160915163630.18026-3-dannym@scratchpost.org>
Message-ID: <20160918201747.GL17518@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 06:36:29PM +0200, Danny Milosavljevic wrote:
> ASoC: sun4i-codec: Some of the registers are sun7i-only.

That line is useless, you already have the commit title.

> 
> Therefore rename "SUN4I_CODEC_SYS_VERI" to "SUN7I_CODEC_AC_DAC_CAL" and
> rename "SUN4I_CODEC_AC_MIC_PHONE_CAL" to "SUN7I_CODEC_AC_MIC_PHONE_CAL".

And removing it, you could make a real sentence, like:

Some of the registers defined in the driver are only usable on the
A20. Rename these registers.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160918/e98af958/attachment.sig>
