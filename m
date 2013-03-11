From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 11 Mar 2013 21:51:02 +0800
Subject: [PATCH] arm: tegra: fuse: export chip id and revision
In-Reply-To: <1363005441-26329-1-git-send-email-dahuang@nvidia.com>
References: <1363005441-26329-1-git-send-email-dahuang@nvidia.com>
Message-ID: <20130311135059.GC25910@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 11, 2013 at 08:37:21PM +0800, Danny Huang wrote:
> Expose tegra chip id and revision in /proc/cpu/chipinfo for user mode
> usage.

It should probably be done in a more generic way.  Check it out
Documentation/ABI/testing/sysfs-devices-soc.

Shawn
