From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 6 May 2011 10:16:44 -0600 (MDT)
Subject: [RFC/PATCH] OMAP PM: remove OMAP_PM_NONE config option
In-Reply-To: <1304673087-24643-1-git-send-email-j-pihet@ti.com>
References: <1304673087-24643-1-git-send-email-j-pihet@ti.com>
Message-ID: <alpine.DEB.2.00.1105061016070.30136@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut Jean

On Fri, 6 May 2011, Jean Pihet wrote:

> The current code base is not linking with the OMAP_PM_NONE
> option set.
> Since the option OMAP_PM_NOOP provides a no-op/debug layer,
> OMAP_PM_NONE can be removed.
> OMAP_PM_NOOP is enabled by default by Kconfig.
> 
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

I'm okay with this but could you please base it on v2.6.39-rc6 so I can 
merge it here?

thanks


- Paul
