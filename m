From: tony@atomide.com (Tony Lindgren)
Date: Tue, 18 Jun 2013 01:31:39 -0700
Subject: [PATCH] ARM: OMAP: TI816X: add powerdomains for TI816x
In-Reply-To: <1369926290-30404-1-git-send-email-aida.mynzhasova@skitlab.ru>
References: <1369926290-30404-1-git-send-email-aida.mynzhasova@skitlab.ru>
Message-ID: <20130618083139.GF5523@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Aida Mynzhasova <aida.mynzhasova@skitlab.ru> [130530 08:10]:
> This patch adds required structures for powerdomain initialization on
> the ti816x. It is impossible to use omap3430 structures in order to
> initialize powerdomains on ti816x, because there are big differences
> between PRCM module base address offsets on these CPUs.

Thanks this looks safe for me to apply so applying to omap-for-v3.11/soc.

Regards,

Tony
