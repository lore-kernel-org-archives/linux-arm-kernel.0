From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 24 Mar 2015 11:32:19 +0100
Subject: [PATCH v6 8/8] ARM: tegra: Add Tegra124 ACTMON support
In-Reply-To: <1426584991-11110-9-git-send-email-tomeu.vizoso@collabora.com>
References: <1426584991-11110-1-git-send-email-tomeu.vizoso@collabora.com>
 <1426584991-11110-9-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150324103218.GE18115@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 10:36:18AM +0100, Tomeu Vizoso wrote:
> Add device node for the ACTMON block to the Tegra124 device tree.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> 
> ---
> 
> v6:	* Remove operating-points property
> 
> v2:	* Add operating-points property
> ---
>  arch/arm/boot/dts/tegra124.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/ab2162bc/attachment.sig>
