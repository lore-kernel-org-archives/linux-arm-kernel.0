From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 3 Jul 2018 14:39:43 +0800
Subject: [PATCH V2] ARM: dts: imx6: correct anatop regulators range
In-Reply-To: <1530497076-15509-1-git-send-email-Anson.Huang@nxp.com>
References: <1530497076-15509-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180703063942.GK4348@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 02, 2018 at 10:04:36AM +0800, Anson Huang wrote:
> According to i.MX6 datasheet, the LDO_1P1's typical
> programming operating range is 1.0V to 1.2V, and
> the LDO_2P5's typical programming operating range
> is 2.25V to 2.75V, correct LDO_1P1 and LDO_2P5's
> regulator range settings for i.MX6 SoCs.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
