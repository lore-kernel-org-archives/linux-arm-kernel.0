From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 12 Oct 2017 11:30:53 -0700
Subject: [PATCH v2 06/10] ARM: dts: Add Broadcom Hurricane 2 DTS include
 file
In-Reply-To: <20170928231502.27069-7-f.fainelli@gmail.com>
References: <20170928231502.27069-1-f.fainelli@gmail.com>
 <20170928231502.27069-7-f.fainelli@gmail.com>
Message-ID: <20171012183053.3143-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 28 Sep 2017 16:14:58 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Describe the Broadcom Hurricane 2 SoC comprised of a Cortex-A9 CPU
> complex along with standard iProc peripherals:
> 
> * timers
> * SPI controller
> * NAND controller
> * a single AMAC (Ethernet MAC controller)
> * dual PCIe controllers
> 
> The design is largely similar to existing iProc-based SoCs such as
> Northstar Plus.
> 
> Acked-by: Jon Mason <jon.mason@broadcom.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
