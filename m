From: khilman@ti.com (Kevin Hilman)
Date: Tue, 10 Jan 2012 09:26:10 -0800
Subject: [PATCHV2 REPOST 0/7] ARM: OMAP3PLUS PM: Add IO DaisyChain support
 via hwmod mux
In-Reply-To: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
 (Vishwanath BS's message of "Wed, 14 Dec 2011 21:31:10 +0530")
References: <1323878477-21122-1-git-send-email-vishwanath.bs@ti.com>
Message-ID: <878vlftqod.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vishwanath BS <vishwanath.bs@ti.com> writes:

> The following patch series provides IO Daisychain feature via omap hwmod mux framework.
> The patch series has been generated against Tero's V11 irq chaining series [1].

Tero's series has now been reworked a bit by Paul for merging in v3.3.

Can you rebase and retest this against Tony's 'uart' branch which now
includes the reworked PRCM handler as well as the UART runtime PM series
that is queued for v3.3.

Thanks,

Kevin
