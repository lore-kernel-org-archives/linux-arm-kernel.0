From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 10 Sep 2018 09:04:49 +0800
Subject: [PATCH] ARM: dts: imx6ul: Enable the PMU node
In-Reply-To: <1536171528-23005-1-git-send-email-festevam@gmail.com>
References: <1536171528-23005-1-git-send-email-festevam@gmail.com>
Message-ID: <20180910010448.GC21992@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2018 at 03:18:48PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> There is no need to keep the PMU disabled.
> 
> Enable it like it is done in the other i.MX dtsi files.
> 
> With this change applied we see:
> 
> [    1.338866] hw perfevents: enabled with armv7_cortex_a7 PMU driver, 5 counters available
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
