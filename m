From: olof@lixom.net (Olof Johansson)
Date: Mon, 20 May 2013 23:51:13 -0700
Subject: [PATCH] ARM: tegra: defconfig fixes
In-Reply-To: <1369076839-31787-1-git-send-email-swarren@wwwdotorg.org>
References: <1369076839-31787-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20130521065113.GJ20453@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 01:07:19PM -0600, Stephen Warren wrote:
> From: Alexandre Courbot <gnurou@gmail.com>
> 
> The AK8975 Kconfig option was renamed during the 3.10 merge window.
> Adjust tegra_defconfig to enable the new name, so it's not missing
> useful features.
> 
> Tegra DRM support used to be enabled in the default Tegra configuration,
> but it now depends on CONFIG_TEGRA_HOST1X which is disabled by default.
> Enable CONFIG_TEGRA_HOST1X so that DRM support is compiled in again.
> 
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> [swarren, squashed Alex's and my changes together]
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
> Olof, Arnd,
> 
> Can this be taken into 3.10? Hopefully Linus won't mind defconfig changes
> sneaking in now. If not, let me know, and I'll for it into Tegra's
> for-3.11/dt branch instead. Thanks.

Since people actually use the defconfigs it does make sense to keep them
working and regression-free.

I think we'll be fine with a rare occurrance of it. We'll find out. :)



-Olof
