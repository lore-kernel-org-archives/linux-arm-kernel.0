From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 27 Aug 2018 10:20:33 +0800
Subject: [PATCH v1] ARM: arm: configs: imx_v6_v7: add
 CONFIG_FW_LOADER_USER_HELPER
In-Reply-To: <1533579655-5498-1-git-send-email-yibin.gong@nxp.com>
References: <1533579655-5498-1-git-send-email-yibin.gong@nxp.com>
Message-ID: <20180827022031.GB3850@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2018 at 02:20:55AM +0800, Robin Gong wrote:
> To support loading sdma firmware automatically from rootfs, enable
> CONFIG_FW_LOADER_USER_HELPER/CONFIG_FW_LOADER_USER_HELPER_FALLBACK.
> Please get sdma firmware from below link and put it into
> rootfs entry -- /lib/firmware/imx/sdma/:
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/imx/sdma
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>

Changed subject prefix like 'ARM: imx_v6_v7_defconfig: ...', and applied
the patch.

Shawn
