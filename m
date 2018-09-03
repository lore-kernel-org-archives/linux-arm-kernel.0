From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 3 Sep 2018 12:46:21 +0800
Subject: [PATCH V2] ARM: dts: imx7s: enable cpuidle driver
In-Reply-To: <1535939141-14338-1-git-send-email-Anson.Huang@nxp.com>
References: <1535939141-14338-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180903044619.GL3850@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 03, 2018 at 09:45:41AM +0800, Anson Huang wrote:
> Enable cpuidle for i.MX7S/D using generic ARM cpuidle
> driver, below 2 idle states enabled:
> 
> 1. ARM WFI;
> 2. SoC WAIT mode.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
