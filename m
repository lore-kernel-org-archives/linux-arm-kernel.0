From: biao.huang@mediatek.com (biao huang)
Date: Mon, 29 Oct 2018 11:32:25 +0800
Subject: [v2, PATCH 0/2] add Ethernet driver support for mt2712
In-Reply-To: <1540782294-27721-1-git-send-email-biao.huang@mediatek.com>
References: <1540782294-27721-1-git-send-email-biao.huang@mediatek.com>
Message-ID: <1540783945.26982.6.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2018-10-29 at 11:04 +0800, Biao Huang wrote:
> The mt2712 Ethernet IP is from Synopsys, so extend stmmac to support mt2712.
> 
sorry, I forgot to add detail descriptions for these patches.

changes in v2:
--since STMMAC driver applied to most Synopsys ip Ethernet, I add
dwmac-mediatek.c to support MediaTek mt2712 in v2.
--abandon Ethernet drivers proposed in v1.
--rewrite dt-binding document for v2 driver.

Best Regards!
