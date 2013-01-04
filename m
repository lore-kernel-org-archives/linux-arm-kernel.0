From: davem@davemloft.net (David Miller)
Date: Fri, 04 Jan 2013 15:16:06 -0800 (PST)
Subject: [PATCH v3 1/1 net-next] NET: FEC: dynamtic check DMA desc buff
 type
In-Reply-To: <1357265063-30528-1-git-send-email-Frank.Li@freescale.com>
References: <1357265063-30528-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130104.151606.181887747842513051.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Fri, 4 Jan 2013 10:04:23 +0800

> MX6 and mx28 support enhanced DMA descriptor buff to support 1588
> ptp. But MX25, MX3x, MX5x can't support enhanced DMA descriptor buff.
> Check fec type and choose correct DMA descriptor buff type.
> 
> Remove static config CONFIG_FEC_PTP.
> ptp function will be auto detected.
> 
> Signed-off-by: Frank Li <Frank.Li@freescale.com>

Applied.
