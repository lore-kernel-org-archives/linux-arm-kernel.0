From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 11 Mar 2013 17:10:29 +0000
Subject: [PATCH] arm: tegra: fuse: export chip id and revision
In-Reply-To: <1363005441-26329-1-git-send-email-dahuang@nvidia.com>
References: <1363005441-26329-1-git-send-email-dahuang@nvidia.com>
Message-ID: <20130311171029.GO4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 11, 2013 at 08:37:21PM +0800, Danny Huang wrote:
> Expose tegra chip id and revision in /proc/cpu/chipinfo for user mode
> usage.

I thought we weren't exporting this stuff out via procfs, but had a
soc specific way to do it - drivers/base/soc.c ?  We have soc_id and
revision attributes there... it seems to do what you want already.
