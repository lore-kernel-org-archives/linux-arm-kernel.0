From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 5 Jan 2012 20:33:46 +0000
Subject: [PATCH] ARM: Fix typo in conversion of ARCH_NR_GPIOS to Kconfig
In-Reply-To: <1325795370-21576-1-git-send-email-swarren@nvidia.com>
References: <1325795370-21576-1-git-send-email-swarren@nvidia.com>
Message-ID: <20120105203346.GE11810@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2012 at 01:29:30PM -0700, Stephen Warren wrote:
> Commit 44986ab "ARM: 7240/1: Make ARCH_NR_GPIO a Kconfig variable"
> spelled ARCH_NR_GPIOS as ARCH_NR_GPIO, hence making the change
> ineffective. This change fixes that.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> This should probably go into 3.3 since the patch it fixes is there. I
> don't think this issue affects any Tegra platform, but I didn't investigate
> the other platforms that set CONFIG_ARCH_NR_GPIO by default now.

Bah, I've just sent my first batch of pull requests to Linus.  Oh well,
things can stay as they are until I send the second set roughly half way
through.  Please stick it in the patch system so it doesn't get forgotten.

Thanks.
