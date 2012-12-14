From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 14 Dec 2012 19:29:15 +0100
Subject: [PATCH v2 1/1] ARM: OMAP2+: omap2plus_defconfig: enable devtmpfs
 and automount
In-Reply-To: <1355508168-32565-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1355508168-32565-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <50CB6FFB.2060600@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 December 2012 07:02 PM, Javier Martinez Canillas wrote:
> Since udev-176 [1], udev no longer creates device nodes under
> /dev and this has to be managed by the kernel devtmpfs filesystem.
>
> This makes devtmpfs filesystem a requirement on newer systems and
> a kernel built with the current OMAP2+ config will not boot on them.
>
> Also, it is good to have devtmpfs at /dev automount enabled by default.
>
> [1]: http://permalink.gmane.org/gmane.linux.hotplug.devel/17230
>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Acked-by: Santosh Shilimkar<santosh.shilimkar@ti.com>
