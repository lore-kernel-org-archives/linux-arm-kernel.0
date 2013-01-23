From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jan 2013 10:15:30 -0500
Subject: [PATCH] ARM: dove: update dove_defconfig with a few useful options
In-Reply-To: <1358099647-22323-1-git-send-email-olof@lixom.net>
References: <1358099647-22323-1-git-send-email-olof@lixom.net>
Message-ID: <20130123151530.GU1758@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 13, 2013 at 09:54:07AM -0800, Olof Johansson wrote:
> This refreshes the dove_defconfig, and adds:
> PRINTK_TIME
> DEVTMPFS
> EXT4
> 
> They're quite useful, and allows booting a cubox ubuntu rootfs on SD card,
> since that by default uses ext4.
> 
> The rest of the churn is due to options and defaults moving around, no
> functional difference.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> 
> ---
>  arch/arm/configs/dove_defconfig | 28 ++++++++--------------------
>  1 file changed, 8 insertions(+), 20 deletions(-)

Applied to mvebu/boards

thx,

Jason.
