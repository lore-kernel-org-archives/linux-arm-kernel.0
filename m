From: davem@davemloft.net (David Miller)
Date: Thu, 12 Jan 2012 20:05:56 -0800 (PST)
Subject: [PATCH v2] net: fsl: fec: handle 10Mbps speed in RMII mode
In-Reply-To: <1326384628-7967-1-git-send-email-eric@eukrea.com>
References: <1326384628-7967-1-git-send-email-eric@eukrea.com>
Message-ID: <20120112.200556.1749523544894504540.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric B?nard <eric@eukrea.com>
Date: Thu, 12 Jan 2012 17:10:28 +0100

> when the link is 10 Mbps and the mode is RMII, it's necessary
> to set FRCONT to 1 in MIIGSK_CFGR to divide the RMII source
> clock by 10 in order to support 10 Mbps operations.
> 
> Signed-off-by: Eric B?nard <eric@eukrea.com>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

Applied.
