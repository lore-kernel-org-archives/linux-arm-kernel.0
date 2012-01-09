From: jdl@jdl.com (Jon Loeliger)
Date: Mon, 09 Jan 2012 12:58:27 -0600
Subject: [PATCH 1/2] dtc: Implement -d option to write out a dependency
 file
In-Reply-To: <1326134295-15547-1-git-send-email-swarren@nvidia.com>
References: <1326134295-15547-1-git-send-email-swarren@nvidia.com>
Message-ID: <E1RkKQN-0000nM-2c@jdl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This will allow callers to rebuild .dtb files when any of the /include/d
> .dtsi files are modified, not just the top-level .dts file.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This patch is against the Linux kernel's copy of dtc, but it applies to
> upstream dtc with a couple of trivial conflicts. I can post a version for
> upstream dtc as well if desired.

If it does go upstream into Linux proper, we should
definitely have it in the main DTC repository.
So if you would, please send me a path that applies there.

Thanks,
jdl
