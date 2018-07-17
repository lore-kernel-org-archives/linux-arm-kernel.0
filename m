From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 17 Jul 2018 11:47:15 +0800
Subject: [PATCH 1/2] ARM: mxs_defconfig: use MXSFB DRM driver
In-Reply-To: <20180712105942.25245-1-stefan@agner.ch>
References: <20180712105942.25245-1-stefan@agner.ch>
Message-ID: <20180717034714.GD4576@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 12:59:41PM +0200, Stefan Agner wrote:
> Use the the DRM driver for MXSFB LCD controller (used in i.MX23/
> i.MX28/i.MX6SX or i.MX7). Remove CONFIG_FB_MXS which will soon be
> removed.
> 
> Note that this does not remove CONFIG_FB. CONFIG_FB gets selected
> implicity by CONFIG_DRM/CONFIG_DRM_KMS_FB_HELPER.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied both, thanks.
