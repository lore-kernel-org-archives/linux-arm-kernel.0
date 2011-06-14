From: tony@atomide.com (Tony Lindgren)
Date: Tue, 14 Jun 2011 04:36:09 -0700
Subject: [RFC 1/2] omap: mcbsp: Drop SPI mode support
In-Reply-To: <1308050632-4733-1-git-send-email-jhnikula@gmail.com>
References: <1308050632-4733-1-git-send-email-jhnikula@gmail.com>
Message-ID: <20110614113608.GP3352@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jarkko Nikula <jhnikula@gmail.com> [110614 04:18]:
> We haven't seen any use for the SPI API in McBSP driver over the years. More
> over, Peter Ujfalusi <peter.ujfalusi@ti.com> noticed that SPI mode is not
> even supported since OMAP2430 so it's very unlikely that we'll see any use
> for it in the future either.

Sounds fair to me, our first priority should be to get this
code moved to live under drivers. If the SPI support is needed,
it can be added back later on.

Regards,

Tony
