From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Nov 2013 09:44:55 -0800
Subject: [PATCHv10 41/41] ARM: OMAP3: use DT clock init if DT data is
 available
In-Reply-To: <1385453182-24421-42-git-send-email-t-kristo@ti.com>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
 <1385453182-24421-42-git-send-email-t-kristo@ti.com>
Message-ID: <20131126174455.GF26766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [131126 00:10]:
> OMAP3 platforms support both DT and non-DT boot at the moment, make
> the clock init work according to the used setup.

We're making omap3 to be DT only as well, so it might make sense to
drop the omap3 clock data as well while at it. Or do it later to
avoid adding dependencies, up to you.

Regards,

Tony
