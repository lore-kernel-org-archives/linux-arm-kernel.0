From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 Sep 2016 11:31:23 +0300
Subject: [PATCH v5 0/3] ASoC: sun4i-codec: Distinguish sun4i from sun7i
In-Reply-To: <20160922071313.12891-1-dannym@scratchpost.org>
References: <20160922071313.12891-1-dannym@scratchpost.org>
Message-ID: <20160922083123.GN8719@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Sep 22, 2016 at 09:13:10AM +0200, Danny Milosavljevic wrote:
> ASoC: sun4i-codec: Introduce mechanism to detect sun7i and provide a
> different regmap different compared to sun4i Allwinner A10.
>  
> The controls will be extended in a forthcoming patch - it is necessary
> to distinguish between sun4i and sun7i controls because they have different
> registers.
>  
> Renamed SUN4I_CODEC_AC_SYS_VERI to SUN7I_CODEC_AC_DAC_CAL and renamed
> SUN4I_CODEC_AC_MIC_PHONE_CAL to SUN7I_CODEC_AC_MIC_PHONE_CAL because these
> are actually not present on Allwinner A10.
> 
> Handle quirks by regmap config and codec and select the correct quirks
> automatically.  

Usually, you would set the history of changes from one version to the
other here.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160922/2b5924b5/attachment.sig>
