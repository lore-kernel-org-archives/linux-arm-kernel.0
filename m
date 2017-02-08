From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 8 Feb 2017 03:47:26 +0100
Subject: [PATCH v2 1/4] Documentation: devicetree: Add document bindings
 for leds-mt6323
In-Reply-To: <1486520357-13096-2-git-send-email-sean.wang@mediatek.com>
References: <1486520357-13096-1-git-send-email-sean.wang@mediatek.com>
 <1486520357-13096-2-git-send-email-sean.wang@mediatek.com>
Message-ID: <20170208024726.GD29174@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +			led0: isink0 {
> +				lebel = "LED0"

label, not lebel.

       Andrew
