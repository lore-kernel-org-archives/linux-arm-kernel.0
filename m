From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Dec 2011 22:00:30 -0800
Subject: [PATCH] arm/tegra: Remove code that's ifndef CONFIG_ARM_GIC
In-Reply-To: <1320263443-32548-1-git-send-email-swarren@nvidia.com>
References: <1320263443-32548-1-git-send-email-swarren@nvidia.com>
Message-ID: <20111208060030.GA20760@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 02, 2011 at 01:50:43PM -0600, Stephen Warren wrote:
> entry-macro.S contains some stale code for chips before Tegra20 that
> apparently didn't use an ARM GIC. All chips supported by mainline use
> an ARM GIC, so rip out the stale code.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied to for-3.3/cleanup


-Olof
