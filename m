From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 19 Jun 2018 09:08:26 +0800
Subject: [PATCH V2 1/3] ARM: imx: add L2 page power control for GPC
In-Reply-To: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
References: <1527993226-19587-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180619010824.GT16091@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 03, 2018 at 10:33:44AM +0800, Anson Huang wrote:
> Some platforms like i.MX6UL/i.MX6SLL have L2
> page power control in GPC, it needs to be
> disabled if ARM is power gated and L2 is NOT
> flushed, add GPC interface to control it.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied all, thanks.
