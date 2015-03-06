From: tony@atomide.com (Tony Lindgren)
Date: Fri, 6 Mar 2015 07:32:55 -0800
Subject: [PATCH 11/24] ARM: OMAP2+: clock: remove support for legacy
 mpurate command line param
In-Reply-To: <1425644939-3232-12-git-send-email-t-kristo@ti.com>
References: <1425644939-3232-1-git-send-email-t-kristo@ti.com>
 <1425644939-3232-12-git-send-email-t-kristo@ti.com>
Message-ID: <20150306153254.GK13520@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150306 04:29]:
> The legacy support is wrong and dangerous, as it doesn't take any
> OPPs into account and does not scale voltages. Switching mpurate should
> be handled through cpufreq.

Hmm I wonder if some systems actually rely on the mpurate cmdline
parameter. If this cannot be fixed properly, you should at least
print an error here.

Regards,

Tony
