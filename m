From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Sep 2015 20:22:09 +0100
Subject: [PATCH v5 10/10] ASoC: rockchip_i2s: modify DMA max burst to 1
In-Reply-To: <1442188182-6181-1-git-send-email-shawn.lin@rock-chips.com>
References: <1442187923-5736-1-git-send-email-shawn.lin@rock-chips.com>
 <1442188182-6181-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <20150916192209.GN12027@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 14, 2015 at 07:49:42AM +0800, Shawn Lin wrote:

> +	default:
> +		dev_info(&pdev->dev, "Default no dma_quirk!\n");
> +		break;
> +	}

Probably printing a message when not using the quirk is a bit noisy
(hopefully future devices will fix this!).  Otherwise

Acked-by: Mark Brown <broonie@kernel.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150916/6a335bf9/attachment.sig>
