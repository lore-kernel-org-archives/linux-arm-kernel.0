From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 5 May 2015 14:18:38 +0200
Subject: [PATCH 7/9] ARM: tegra: enable HDA in defconfig
In-Reply-To: <16307b8af5a65c8ba5a2b9cb640b4718142adbca.1428700856.git.marcel.ziswiler@toradex.com>
References: <cover.1428700856.git.marcel.ziswiler@toradex.com>
 <16307b8af5a65c8ba5a2b9cb640b4718142adbca.1428700856.git.marcel.ziswiler@toradex.com>
Message-ID: <20150505121837.GF30501@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 10, 2015 at 11:36:02PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> ---
>  arch/arm/configs/tegra_defconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)

I've squashed this into a single commit with the patch that enables
watchdog support.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150505/f289d2d2/attachment.sig>
