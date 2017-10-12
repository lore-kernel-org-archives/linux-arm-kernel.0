From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 12 Oct 2017 11:31:47 -0700
Subject: [PATCH v2 05/10] clk: bcm: Add Broadcom Hurricane 2 clock support
In-Reply-To: <20170928231502.27069-6-f.fainelli@gmail.com>
References: <20170928231502.27069-1-f.fainelli@gmail.com>
 <20170928231502.27069-6-f.fainelli@gmail.com>
Message-ID: <20171012183147.3473-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Sep 2017 16:14:57 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Add support for the Broadcom Hurricane 2 SoC clock controller. We can
> re-use the existing iProc clock library since the SoC's architecture is
> largely the same as its predecessors. For now, we just initialize the
> iProc ARM PLL.
> 
> Acked-by: Jon Mason <jon.mason@broadcom.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to drivers/next, thanks!
--
Florian
