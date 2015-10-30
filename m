From: davem@davemloft.net (David Miller)
Date: Fri, 30 Oct 2015 12:22:20 +0900 (KST)
Subject: [PATCH net-next v2 0/2] drivers: xgene: Add support RGMII
 TX/RX delay configuration
In-Reply-To: <1445898316-21372-1-git-send-email-isubramanian@apm.com>
References: <1445898316-21372-1-git-send-email-isubramanian@apm.com>
Message-ID: <20151030.122220.1215954538392198950.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Mon, 26 Oct 2015 15:25:14 -0700

> X-Gene RGMII ethernet controller has a RGMII bridge that performs the
> task of converting the RGMII signal {RX_CLK,RX_CTL, RX_DATA[3:0]} from
> PHY to GMII signal {RX_DV,RX_ER,RX_DATA[7:0]} and vice versa.  This
> RGMII bridge has a provision to internally delay the input RX_CLK and
> the output TX_CLK using configuration registers. This will help in
> maintain the CLK-CTL delay relationship in various operating
> conditions.
> 
> This patch adds support RGMII TX/RX delay configuration.
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>

Series applied, thanks.
