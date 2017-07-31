From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 31 Jul 2017 12:22:55 +0200
Subject: [PATCH 3/3] ARM: configs: Add Tegra I2S interfaces to
 multi_v7_defconfig
In-Reply-To: <20170730112220.15525-3-contact@paulk.fr>
References: <20170730112220.15525-1-contact@paulk.fr>
 <20170730112220.15525-3-contact@paulk.fr>
Message-ID: <20170731102255.GD26667@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 30, 2017 at 01:22:20PM +0200, Paul Kocialkowski wrote:
> This selects both the Tegra20 and Tegra30 I2S interfaces (that were
> previously auto-selected by Kconfig but are not anymore) to
> multi_v7_defconfig, as modules.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  arch/arm/configs/multi_v7_defconfig | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170731/dcf0f1fa/attachment.sig>
