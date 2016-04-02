From: broonie@kernel.org (Mark Brown)
Date: Sat, 2 Apr 2016 09:34:12 -0700
Subject: [PATCH v2] ASoC: mediatek: Add second I2S on mt8173-rt5650
 machine driver
In-Reply-To: <1459498877-5810-1-git-send-email-pc.liao@mediatek.com>
References: <1459498877-5810-1-git-send-email-pc.liao@mediatek.com>
Message-ID: <20160402163412.GC2350@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 04:21:17PM +0800, PC Liao wrote:

> +Optional properties:
> +- mediatek,audio-codec-dai-capture: audio codec dai on capture path
> +  rt5645-aif1: Default setting. Connect rt5650 I2S1 for capture
> +  rt5645-aif2: Connect rt5650 I2S2 for capture

No, this has exactly the same issue as the previous version.  To repeat
what I said last time I would expect that the driver should just specify
the links between the DAIs.  Look at how other devices reference DAIs.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160402/bf05092e/attachment-0001.sig>
