From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 31 Aug 2011 16:57:56 +0200
Subject: [PATCH 1/2 v4] at91: merge board usb-a9260 and usb-a9263 together
In-Reply-To: <1314721553-3283-1-git-send-email-plagnioj@jcrosoft.com>
References: <1314281314-28912-1-git-send-email-nicolas.ferre@atmel.com>
	<1314721553-3283-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <4E5E4BF4.50109@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 30/08/2011 18:25, Jean-Christophe PLAGNIOL-VILLARD :
> From: Nico Erfurth <ne@erfurth.eu>
> 
> Merge boards together as they are barely the same.
> 
> Signed-off-by: Nico Erfurth <ne@erfurth.eu>
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> [nicolas.ferre at atmel.com: updated to new machine_desc structure]
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Gregory Hermant <gregory.hermant@calao-systems.com>
> ---
> v4:
> fix for 9260
> 	.map_io		= at91_map_io

Ok, thanks for correcting this.

BR,
-- 
Nicolas Ferre
