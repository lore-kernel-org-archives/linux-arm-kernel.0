From: florian.meier@koalo.de (Florian Meier)
Date: Fri, 22 Nov 2013 14:32:19 +0100
Subject: [PATCHv4] ASoC: Add support for BCM2835
In-Reply-To: <528E4E4A.20403@koalo.de>
References: <528E4E4A.20403@koalo.de>
Message-ID: <528F5CE3.30105@koalo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev),
> +			   GFP_KERNEL);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);

Found a typo here, should be IS_ERR(dev) and PTR_ERR(dev).

Is the patch acceptable apart from that now?

Greetings,
Florian
