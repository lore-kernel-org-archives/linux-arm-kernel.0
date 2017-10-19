From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Oct 2017 12:50:17 +0200
Subject: [PATCH v2 3/6] arm64: tegra: Add VIC on Tegra186
In-Reply-To: <20170905084306.19318-4-mperttunen@nvidia.com>
References: <20170905084306.19318-1-mperttunen@nvidia.com>
 <20170905084306.19318-4-mperttunen@nvidia.com>
Message-ID: <20171019105017.GN9005@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 05, 2017 at 11:43:03AM +0300, Mikko Perttunen wrote:
> Add a node for the Video Image Compositor on the Tegra186.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> v2:
> - Fixed reg property in accordance with changed parent cells.
> 
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171019/7f1d1e60/attachment.sig>
