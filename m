From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Jan 2015 21:24:22 +0100
Subject: [PATCH 0/4] Drop legacy support for omap3517
In-Reply-To: <1421171865-5209-1-git-send-email-tony@atomide.com>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
Message-ID: <10549142.7lWnPtPtZG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 January 2015 09:57:41 Tony Lindgren wrote:
> 
> It seems we can now drop omap3517 legacy booting support to get
> a bit closer to making all of omap3 boot in device tree only mode.
> 
> All these boards have at least minimal support for booting with
> device tree, and pretty much anything supported with the legacy
> board files can be configured also for device tree based booting
> if not done already.

Ah, very nice.

Just out of curiosity, what are the remaining showstoppers for
the 3430 and 3530 based boards?

	Arnd
