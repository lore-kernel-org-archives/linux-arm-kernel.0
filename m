From: tony@atomide.com (Tony Lindgren)
Date: Tue, 16 Nov 2010 13:18:38 -0800
Subject: [PATCH v2] OMAP1: drop AMS_DELTA_FIQ config option
In-Reply-To: <201011060256.00485.jkrzyszt@tis.icnet.pl>
References: <201011060256.00485.jkrzyszt@tis.icnet.pl>
Message-ID: <20101116211838.GI9264@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [101105 18:48]:
> This patches removes a config option that was used to select a FIQ 
> handler to be build for Amstrad Delta, as required by the on-board serio 
> interface driver. Not having any problem reports received since it was 
> introduced in 2.6.35, the FIQ handler can now be built and initialized by 
> default, thus reqiring no extra config option.

Thanks, I'll queue this for 2.6.38 merge window.

Tony
