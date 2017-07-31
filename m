From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 31 Jul 2017 16:48:13 +0200
Subject: [PATCH] ARM: tegra: Register host1x node with iommu binding on
 tegra124
In-Reply-To: <20170709163614.6746-1-contact@paulk.fr>
References: <20170709163614.6746-1-contact@paulk.fr>
Message-ID: <20170731144813.GA27815@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 09, 2017 at 07:36:14PM +0300, Paul Kocialkowski wrote:
> This registers the host1x node with the SMMU (as HC swgroup) to allow
> the host1x code to attach to it. It avoid failing the probe sequence,
> which resulted in the tegra drm driver not probing and thus nothing
> being displayed on-screen.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/boot/dts/tegra124.dtsi | 1 +
>  1 file changed, 1 insertion(+)

Applied to for-4.14/arm/dt, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170731/38fd6855/attachment-0001.sig>
