From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 16 Jun 2016 10:05:42 +0800
Subject: [PATCH] ARM: dts: imx6ul-pico-hobbit: Fix Ethernet PHY reset GPIO
In-Reply-To: <1466008481-10576-1-git-send-email-diego.dorta@nxp.com>
References: <1466008481-10576-1-git-send-email-diego.dorta@nxp.com>
Message-ID: <20160616020542.GT20243@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 01:34:41PM -0300, Diego Dorta wrote:
> According to the imx6ul-pico-hobbit schematics the Ethernet PHY reset GPIO
> is GPIO1_28, so fix it accordingly.
> 
> Also adjust the reset duration to 1ms, because the KSZ8081 datasheet
> requires 500?s.
> 
> Signed-off-by: Diego Dorta <diego.dorta@nxp.com>

Applied, thanks.
