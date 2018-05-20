From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 20 May 2018 21:01:32 +0800
Subject: [PATCH] clk: imx6sx: disable unnecessary clocks during clock
 initialization
In-Reply-To: <1526533248-21990-1-git-send-email-Anson.Huang@nxp.com>
References: <1526533248-21990-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180520130130.GA26863@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 01:00:47PM +0800, Anson Huang wrote:
> Disable those unnecessary clocks during kernel boot up to save power,
> those modules clock should be managed by modules driver in runtime.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
