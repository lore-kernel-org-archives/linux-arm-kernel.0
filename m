From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 31 Jan 2017 21:06:17 +0100
Subject: [PATCH net-next 0/6] drivers: net: xgene-v2: Add RGMII based 1G
 driver
In-Reply-To: <1485889401-13909-1-git-send-email-isubramanian@apm.com>
References: <1485889401-13909-1-git-send-email-isubramanian@apm.com>
Message-ID: <20170131200617.GN5656@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 11:03:15AM -0800, Iyappan Subramanian wrote:
> This patch set adds support for RGMII based 1GbE hardware which uses a linked
> list of DMA descriptor architecture (v2) for APM X-Gene SoCs.

Hi Iyappan

Should we assume there are more patches to follow adding MDIO bus
support and phylib integration?

	Andrew
