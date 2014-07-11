From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 11 Jul 2014 14:59:04 +0200
Subject: [PATCH v5 3/4] ARM: tegra: tegra124: Add XUSB pad controller
In-Reply-To: <1403177830-28595-3-git-send-email-thierry.reding@gmail.com>
References: <1403177830-28595-1-git-send-email-thierry.reding@gmail.com>
 <1403177830-28595-3-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140711125903.GC10744@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 19, 2014 at 01:37:09PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The device tree node in the SoC file contains only the resources (such
> as registers, resets, ...) but none of the lane assignment information
> since that's board specific and belongs in the board file.
> 
> Tested-by: Mikko Perttunen <mperttunen@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - include dt-bindings/pinctrl/pinctrl-tegra-xusb.h so that board files
>   don't have to include it explicitly
> - remove unneeded #address-cells/#size-cells = <0>
> - add padctl label for XUSB pad controller node
> 
>  arch/arm/boot/dts/tegra124.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Patches 3 and 4 applied to the for-3.17/dt branch and rebased the branch
on for-3.17/xusb-padctl because of the dependency on the dt-bindings
header.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140711/de856bec/attachment.sig>
