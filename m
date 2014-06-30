From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 30 Jun 2014 10:04:23 -0600
Subject: [PATCH v5 2/4] pinctrl: Add NVIDIA Tegra XUSB pad controller
 support
In-Reply-To: <1403177830-28595-2-git-send-email-thierry.reding@gmail.com>
References: <1403177830-28595-1-git-send-email-thierry.reding@gmail.com>
 <1403177830-28595-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <53B18A87.7040305@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2014 05:37 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The XUSB pad controller found on NVIDIA Tegra SoCs provides several pads
> that lanes can be assigned to in order to support a variety of interface
> options: USB 2.0, USB 3.0, PCIe and SATA.
> 
> In addition to the pin controller used to assign lanes to pads two PHYs
> are exposed to allow the bricks for PCIe and SATA to be powered up and
> down by PCIe and SATA drivers.

Linus, does the driver look OK? I'm hoping for an ack from you so that I
can take this series through the Tegra tree to resolve some
dependencies; we have various other drivers that depend on this series.

Thanks!
