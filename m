From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 3 Sep 2018 08:00:50 +0800
Subject: [PATCH V2 1/2] soc: imx: gpc: use A_CORE instread of A7 for more
 i.MX platforms
In-Reply-To: <1535445406-19633-1-git-send-email-Anson.Huang@nxp.com>
References: <1535445406-19633-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180903000048.GT3850@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 28, 2018 at 04:36:45PM +0800, Anson Huang wrote:
> gpcv2 driver is NOT just used on i.MX7D which has Cortex-A7
> cores, but also on i.MX8MQ/i.MX8MM platforms which use Cortex-A53
> cores, so let's use A_CORE instread of A7 to avoid confusion.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Acked-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Applied both, thanks.
