From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 17 Jul 2018 13:51:50 +0800
Subject: [PATCH 1/3] ARM: dts: imx53-ppd: Enable secure-reg-access
In-Reply-To: <1531400558-20700-1-git-send-email-fabio.estevam@nxp.com>
References: <1531400558-20700-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20180717055149.GE4576@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 10:02:36AM -0300, Fabio Estevam wrote:
> From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> 
> Add 'secure-reg-access' property to enable PMU and hardware counters
> so that they can be properly used with the 'perf' tool.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> [fabio: kept the change only in imx53-ppd context]
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied all, thanks.
