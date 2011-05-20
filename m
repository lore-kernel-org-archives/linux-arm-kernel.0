From: koen@beagleboard.org (Koen Kooi)
Date: Fri, 20 May 2011 17:57:34 +0200
Subject: [beagleboard] [PATCH v2 2/2] OMAP3BEAGLE: Add support for mt9p031
	sensor driver.
In-Reply-To: <1305899272-31839-2-git-send-email-javier.martin@vista-silicon.com>
References: <1305899272-31839-1-git-send-email-javier.martin@vista-silicon.com>
	<1305899272-31839-2-git-send-email-javier.martin@vista-silicon.com>
Message-ID: <DDCBBAA2-C49C-4952-9D1B-519D8A3AB41E@beagleboard.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Op 20 mei 2011, om 15:47 heeft Javier Martin het volgende geschreven:

> isp.h file has to be included as a temporal measure
> since clocks of the isp are not exposed yet.
> 
> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> ---
> arch/arm/mach-omap2/board-omap3beagle.c |  127 ++++++++++++++++++++++++++++++-

Javier,

In previous patch sets we put that in a seperate file (omap3beagle-camera.c) so we don't clutter up the board file with all the different sensor drivers. Would it make sense to do the same with the current patches? It looks like MCF cuts down a lot on the boilerplace needed already.

regards,

Koen
