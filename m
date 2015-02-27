From: vigneshr@ti.com (Vignesh R)
Date: Fri, 27 Feb 2015 16:01:03 +0530
Subject: [PATCH 2/2] w1: masters: omap_hdq: Add support for 1-wire mode
In-Reply-To: <10805905.OnX7kRTk9d@wuerfel>
References: <1425029057-5075-1-git-send-email-vigneshr@ti.com>
 <1425029057-5075-2-git-send-email-vigneshr@ti.com>
 <10805905.OnX7kRTk9d@wuerfel>
Message-ID: <54F04767.5070001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 27 February 2015 03:25 PM, Arnd Bergmann wrote:
> On Friday 27 February 2015 14:54:17 Vignesh R wrote:
>> +- compatible : should be "ti,omap3-1w" or "ti,am43xx-hdq"
>>
> 
> Do not use wildcards in the compatible string, use real part numbers
> if you don't know the actual name of the device.


The DT node for hdq on AM437x is already present in mainline
(commit: 741cac5f00beb) and it declares compatibility as
"ti,am43xx-hdq". Hence, I cannot change into anything different.

Regards
Vignesh
