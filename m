From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 26 Sep 2018 17:20:06 +0800
Subject: [PATCH V2 1/2] ARM: dts: imx6ul: use nvmem-cells for cpu speed
 grading
In-Reply-To: <1537154264-23252-1-git-send-email-Anson.Huang@nxp.com>
References: <1537154264-23252-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180926092004.GE26692@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 17, 2018 at 11:17:43AM +0800, Anson Huang wrote:
> On i.MX6UL, accessing OCOTP directly is wrong because the ocotp clock
> needs to be enabled first, so use the nvmem-cells binding instead.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> no change since V1.

Okay, I just applied v1 of this patch.

Shawn
