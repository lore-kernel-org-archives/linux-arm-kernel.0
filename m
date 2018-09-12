From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 12 Sep 2018 09:25:01 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_TMPFS_POSIX_ACL
In-Reply-To: <1536601523-11797-1-git-send-email-festevam@gmail.com>
References: <1536601523-11797-1-git-send-email-festevam@gmail.com>
Message-ID: <20180912012459.GF28469@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2018 at 02:45:23PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Andreas M?ller reports:
> 
> "Fixes:
> 
> | Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[220]: Failed to apply ACL on /dev/v4l-subdev0: Operation not supported
> | Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[224]: Failed to apply ACL on /dev/v4l-subdev1: Operation not supported
> | Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[215]: Failed to apply ACL on /dev/v4l-subdev10: Operation not supported
> | Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[228]: Failed to apply ACL on /dev/v4l-subdev2: Operation not supported
> | Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[232]: Failed to apply ACL on /dev/v4l-subdev5: Operation not supported
> | Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[217]: Failed to apply ACL on /dev/v4l-subdev11: Operation not supported
> | Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[214]: Failed to apply ACL on /dev/dri/card1: Operation not supported
> | Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[216]: Failed to apply ACL on /dev/v4l-subdev8: Operation not supported
> | Sep 04 09:05:10 imx6qdl-variscite-som systemd-udevd[226]: Failed to apply ACL on /dev/v4l-subdev9: Operation not supported
> 
> and nasty follow-ups: Starting weston from sddm as unpriviledged user fails
> with some hints on missing access rights."
> 
> Select the CONFIG_TMPFS_POSIX_ACL option to fix these issues.
> 
> Reported-by: Andreas M?ller <schnitzeltony@gmail.com>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
