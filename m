From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Oct 2017 12:50:05 +0200
Subject: [PATCH v2 2/6] arm64: tegra: Add host1x on Tegra186
In-Reply-To: <20170905084306.19318-3-mperttunen@nvidia.com>
References: <20170905084306.19318-1-mperttunen@nvidia.com>
 <20170905084306.19318-3-mperttunen@nvidia.com>
Message-ID: <20171019105005.GM9005@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 05, 2017 at 11:43:02AM +0300, Mikko Perttunen wrote:
> Add the node for Host1x on the Tegra186, without any subdevices
> for now.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v2:
> - Changed address-cells and size-cells to 1 and fixed the ranges
>   property correspondingly.
> 
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171019/dc8120c3/attachment.sig>
