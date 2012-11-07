From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Nov 2012 17:08:10 -0800
Subject: [GIT PULL] OMAP: PM: voltage layer updates for v3.8
In-Reply-To: <87bofa1e11.fsf@deeprootsystems.com>
References: <87bofa1e11.fsf@deeprootsystems.com>
Message-ID: <20121107010809.GX6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [121106 15:58]:
> Tony,
> 
> Here's a set of voltage layer updates for v3.8.
> 
> This implements all the framework changes necessary to get
> auto-ret/auto-off working, but the main change to enable
> auto-ret/auto-off is awaiting the functional power state changes that
> are still under review/rework.
> 
> Also, this fixes that pesky VC warning about I2C config not matching
> other channels that was reported by Russell.
> 
> Kevin
> 
> 
> The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:
> 
>   Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/for_3.8-pm-voltage
> 
> for you to fetch changes up to df7cded30ced539d3b4e6bae9f3011d98c069d41:
> 
>   ARM: OMAP4: OPP: add OMAP4460 definitions (2012-11-05 15:31:49 -0800)
> 
> ----------------------------------------------------------------
> OMAP voltage layer updates towards supporting auto-retention/auto-off

Thanks pulling into omap-for-v3.8/pm.

Regards,

Tony
