From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 7 Nov 2011 14:31:25 -0700 (MST)
Subject: Fix handling of return value in omap3xx_hwmod_init and sr warning.
In-Reply-To: <1320701417-16818-1-git-send-email-J.Kilb@phytec.de>
References: <1320701417-16818-1-git-send-email-J.Kilb@phytec.de>
Message-ID: <alpine.DEB.2.00.1111071431070.12394@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Nov 2011, Juergen Kilb wrote:

> After this, I got some new warnings during bootup about sr1_hwmod and sr2_hwmod.
> This is fixed with PATCH2/2.

Thanks for the patches, but these should be already fixed by 

http://www.spinics.net/lists/arm-kernel/msg143549.html

- Paul
