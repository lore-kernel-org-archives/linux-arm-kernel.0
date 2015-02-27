From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 27 Feb 2015 10:55:12 +0100
Subject: [PATCH 2/2] w1: masters: omap_hdq: Add support for 1-wire mode
In-Reply-To: <1425029057-5075-2-git-send-email-vigneshr@ti.com>
References: <1425029057-5075-1-git-send-email-vigneshr@ti.com>
 <1425029057-5075-2-git-send-email-vigneshr@ti.com>
Message-ID: <10805905.OnX7kRTk9d@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 February 2015 14:54:17 Vignesh R wrote:
> +- compatible : should be "ti,omap3-1w" or "ti,am43xx-hdq"
> 

Do not use wildcards in the compatible string, use real part numbers
if you don't know the actual name of the device.

	Arnd
