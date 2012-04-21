From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 21 Apr 2012 11:46:29 +0000
Subject: [PATCH] Defconfig update for LPC32xx
In-Reply-To: <1335006394-26810-1-git-send-email-stigge@antcom.de>
References: <1335006394-26810-1-git-send-email-stigge@antcom.de>
Message-ID: <201204211146.29929.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 April 2012, Roland Stigge wrote:
> This patch updates the defconfig for the LPC32xx SoC after device tree
> conversion:
> 
> * Adjustment to DT conversion, added new driver support
> * Added IPv6
> * Increased kernel log buffer
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> 

Hi Roland,

I think the latest version of all of your patches is good, but I've
lost track of which ones you want to go through arm-soc. Can you send
me pull requests for each series you want applied on monday if you get
no more comments?

	Arnd
