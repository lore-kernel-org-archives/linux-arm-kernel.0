From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 Mar 2014 09:32:43 -0800
Subject: [PATCHv2 14/14] ARM: OMAP3: clock: remove legacy clock data
In-Reply-To: <1393924700-6510-15-git-send-email-t-kristo@ti.com>
References: <1393924700-6510-1-git-send-email-t-kristo@ti.com>
 <1393924700-6510-15-git-send-email-t-kristo@ti.com>
Message-ID: <20140304173242.GB17470@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [140304 01:22]:
> This is no longer needed as clock data is provided through DT.

And this one we cannot apply yet until omap3 is booting in device tree
only mode.

Regards,

Tony
