From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 6 Jan 2015 14:08:39 +0100
Subject: [PATCH 4/4] ARM: tegra: remove wp-gpios from the generic nyan dtsi
In-Reply-To: <1420540653-14816-5-git-send-email-tomeu.vizoso@collabora.com>
References: <1420540653-14816-1-git-send-email-tomeu.vizoso@collabora.com>
 <1420540653-14816-5-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150106130838.GG31830@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 11:37:29AM +0100, Tomeu Vizoso wrote:
> As the nyan-blaze has a micro-sd slot, as opposed to nyan-big, which has a full SD
> slot.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---
>  arch/arm/boot/dts/tegra124-nyan-big.dts | 4 ++++
>  arch/arm/boot/dts/tegra124-nyan.dtsi    | 1 -
>  2 files changed, 4 insertions(+), 1 deletion(-)

Shouldn't this be squashed into patch 2/4?

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150106/ed6766f3/attachment.sig>
