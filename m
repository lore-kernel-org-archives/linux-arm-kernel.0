From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 24 Feb 2018 16:24:23 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Re-sync defconfig
In-Reply-To: <1518628339-6337-1-git-send-email-festevam@gmail.com>
References: <1518628339-6337-1-git-send-email-festevam@gmail.com>
Message-ID: <20180224082422.GI3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 14, 2018 at 03:12:19PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Re-sync the defconfig by doing:
> 
> make savedefconfig
> cp defconfig arch/arm/configs/imx_v6_v7_defconfig
> 
> Checked that all the removed options are still enabled by Kconfig logic.
> 
> The exception is CONFIG_SOC_CAMERA_OV2640, which is only used by some
> mx31 machines. As the mx3_camera driver has been removed from the kernel
> tree, removing CONFIG_SOC_CAMERA_OV2640 is not an issue.
> 
> So keep it in sync to help further changes in defconfig.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
