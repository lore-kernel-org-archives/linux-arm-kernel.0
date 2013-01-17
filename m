From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Jan 2013 10:19:38 +0800
Subject: [PATCH] ARM: mxs_defconfig: Select CONFIG_DEVTMPFS_MOUNT
In-Reply-To: <1358386324-23995-1-git-send-email-festevam@gmail.com>
References: <1358386324-23995-1-git-send-email-festevam@gmail.com>
Message-ID: <20130117021937.GF26179@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 11:32:04PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Newer versions of udev (such as 182) requires CONFIG_DEVTMPFS_MOUNT to be 
> selected, otherwise we get a stuck console:
> 
> Starting udev
> Starting Bootlog daemon: bootlogd: cannot deduce real console device
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks.
