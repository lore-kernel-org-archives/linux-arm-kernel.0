From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Oct 2017 12:49:52 +0200
Subject: [PATCH v2 1/6] arm64: tegra: Add #power-domain-cells for BPMP
In-Reply-To: <20170905084306.19318-2-mperttunen@nvidia.com>
References: <20170905084306.19318-1-mperttunen@nvidia.com>
 <20170905084306.19318-2-mperttunen@nvidia.com>
Message-ID: <20171019104952.GL9005@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 05, 2017 at 11:43:01AM +0300, Mikko Perttunen wrote:
> Add #power-domain-cells for the BPMP node on Tegra186 so that the power
> domain provider may be used.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra186.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171019/e5362771/attachment.sig>
