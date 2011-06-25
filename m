From: koen@dominion.thruhere.net (Koen Kooi)
Date: Sat, 25 Jun 2011 10:16:35 +0200
Subject: [PATCH] omap3: beagle: Use GPTIMERi 1 for clockevents
In-Reply-To: <1308932625-17632-1-git-send-email-premi@ti.com>
References: <1308932625-17632-1-git-send-email-premi@ti.com>
Message-ID: <86CFE860-E18E-4B96-A753-11EB7C5C1C86@dominion.thruhere.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Op 24 jun 2011, om 18:23 heeft Sanjeev Premi het volgende geschreven:

> The current selection of the GPTIMER on was result of
> a hardware issue in early versions of the Beagleboards
> (Ax and B1 thru B4). [1] [2]
> 
> Its been long since the hardware issue has been fixed.
> This patch uses GPTIMER 1 for all newer board revisions
> incl. Beagleboard XM.

What's the reason for switching away from gptimer12? Nothing in your patch or changelog says why.
