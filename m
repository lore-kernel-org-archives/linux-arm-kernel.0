From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 22 Nov 2018 16:19:32 +0100
Subject: [v5, PATCH 2/2] dt-binding: mediatek-dwmac: add binding document
 for MediaTek MT2712 DWMAC
In-Reply-To: <1542882521-18874-3-git-send-email-biao.huang@mediatek.com>
References: <1542882521-18874-1-git-send-email-biao.huang@mediatek.com>
 <1542882521-18874-3-git-send-email-biao.huang@mediatek.com>
Message-ID: <20181122151932.GD15403@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 06:28:41PM +0800, Biao Huang wrote:
> The commit adds the device tree binding documentation for the MediaTek DWMAC
> found on MediaTek MT2712.
> 
> Signed-off-by: Biao Huang <biao.huang@mediatek.com>

> +Optional properties:
> +- mediatek,tx-delay: TX clock delay macro value. Range is 0~31. Default is 0.
> +	It should be defined for rgmii/rgmii-rxid/mii interface.
> +- mediatek,rx-delay: RX clock delay macro value. Range is 0~31. Default is 0.
> +	It should be defined for rgmii/rgmii-txid/mii/rmii interface.

You have received the same feedback at least twice now, from two
different maintainers, that the delay should be specified in pS, and
the driver should figure out what values to place into registers.

You should not ignore feedback like that. If you don't understand the
feedback, please ask us to explain it. If you don't agree with the
feedback, you need to argue why you think it is wrong, or why what you
are doing is better, etc.

We are here to help, but just ignoring us won't get you anywhere.

For the moment:

NACK

	Andrew
