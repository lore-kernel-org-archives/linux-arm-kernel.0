From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 24 Jan 2016 17:51:02 +0100
Subject: [PATCH 2/2] arm/mach-imx: enable big endian mode
In-Reply-To: <1453651346-12760-2-git-send-email-johannes@sipsolutions.net>
References: <1453651346-12760-1-git-send-email-johannes@sipsolutions.net>
 <1453651346-12760-2-git-send-email-johannes@sipsolutions.net>
Message-ID: <121144309.VkSBWhRtFa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 24 January 2016 17:02:26 Johannes Berg wrote:
> Enable ARM big-endian mode on mach-imx. This requires adding some
> byte swapping in the debug functions (which otherwise hang forever)
> and of course the secondary core bringup.
> 
> Tested (on top of 4.4) on i.MX6 HummingBoard quad-core (IMX6Q).
> 
> The patch is pretty much as suggested by Arnd Bergmann, thanks!
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

(adding Shawn to Cc)
