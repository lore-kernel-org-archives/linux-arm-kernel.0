From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 21 Mar 2013 07:23:07 +0100
Subject: [PATCH 13/16] thermal: mvebu: Add support for Marvell Dove SoC
 family
In-Reply-To: <1363818997-23137-14-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-14-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130321062307.GI21478@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -	priv->control = devm_request_and_ioremap(&pdev->dev, res);
> -	if (!priv->control) {
> -		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> -		return -EADDRNOTAVAIL;
> -	}


Hi Ezequiel

I've not looked too hard, but i don't see the equivalent of the above
in your new probe function.

   Andrew
