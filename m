From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 26 Sep 2018 17:15:35 +0800
Subject: [PATCH 1/2] ARM: dts: imx6ul: use nvmem-cells for cpu speed
 grading
In-Reply-To: <1536893962-11200-1-git-send-email-Anson.Huang@nxp.com>
References: <1536893962-11200-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180926091533.GD26692@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 14, 2018 at 10:59:21AM +0800, Anson Huang wrote:
> On i.MX6UL, accessing OCOTP directly is wrong because the ocotp clock
> needs to be enabled first, so use the nvmem-cells binding instead.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied this one, thanks.
