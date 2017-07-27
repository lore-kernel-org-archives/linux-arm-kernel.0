From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 27 Jul 2017 15:38:00 +0200
Subject: [PATCH v2 01/11] net: phy: Add rockchip phy driver support
In-Reply-To: <1501160156-30328-2-git-send-email-david.wu@rock-chips.com>
References: <1501160156-30328-1-git-send-email-david.wu@rock-chips.com>
 <1501160156-30328-2-git-send-email-david.wu@rock-chips.com>
Message-ID: <20170727133800.GC18666@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	/*
> +	 * If mode switch happens from 10BT to 100BT, all DSP/AFE
> +	 * registers are set to default values. So any AFE/DSP
> +	 * registers have to be re-initialized in this case.
> +	 */

Hi David

Are they also lost on suspend and resume?

    Andrew
