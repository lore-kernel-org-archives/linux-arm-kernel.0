From: khilman@ti.com (Kevin Hilman)
Date: Wed, 15 Jun 2011 16:48:55 -0700
Subject: [RESEND PATCH 0/2] ARM IRQ Kconfig patches
In-Reply-To: <1308142960-20767-1-git-send-email-balbi@ti.com> (Felipe Balbi's
	message of "Wed, 15 Jun 2011 16:02:38 +0300")
References: <1308142960-20767-1-git-send-email-balbi@ti.com>
Message-ID: <8762o61wrc.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe Balbi <balbi@ti.com> writes:

> I have lost count how many times I have sent
> these patches. Will someone either take them
> in or NAK them so I stop sending ??
>
> Felipe Balbi (2):
>   arm: Kconfig: select correct HAVE_SPARSE_IRQ symbol
>   arm: Kconfig: allow OMAP to use sparse IRQ numbering
>

Tested-by: Kevin Hilman <khilman@ti.com>

Looks good to me.  Built with CONFIG_SPARSE_IRQ=y and boot tested on
OMAP3430/n900 & OMAP4430/Blaze.

Kevin
