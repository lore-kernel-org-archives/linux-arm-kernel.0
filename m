From: b32955@freescale.com (Huang Shijie)
Date: Mon, 12 May 2014 11:40:37 +0800
Subject: [PATCH 1/5] serial: imx: remove unneeded imx_transmit_buffer()
 from imx_start_tx()
In-Reply-To: <1399648788-26061-2-git-send-email-dean_jenkins@mentor.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
 <1399648788-26061-2-git-send-email-dean_jenkins@mentor.com>
Message-ID: <537042B5.2040600@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2014?05?09? 23:19, dean_jenkins at mentor.com ??:
> Use imx_start_tx() just to enable the TX interrupt. It's the job of the
> TX interrupt ISR to fill the transmit buffer, then. If the transmit buffer
> is empty, the TX interrupt should be executed as soon as the start_tx()
> enables the interrupt, so there is no reason for the extra
> imx_transmit_buffer() call, here. Remove it.
I don't know why this patch needed?
What problem this patch fix or improve?

thanks
Huang Shijie
