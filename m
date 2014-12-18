From: xerofoify@gmail.com (nick)
Date: Thu, 18 Dec 2014 08:48:10 -0500
Subject: Weird/Unneeded call to msleep in exynos_mipi_dsi_wr_data in
 exynos_mipi_dsi_common.c
In-Reply-To: <1418909978.2236.0.camel@pengutronix.de>
References: <54920A54.2060608@gmail.com> <5492ABE7.1060900@samsung.com>	
 <5492D80E.3010906@gmail.com> <1418909978.2236.0.camel@pengutronix.de>
Message-ID: <5492DB1A.2020704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lucas,
That's fair do you known of anyone who does have the hardware so we can test my patch. If you do then we can get this fixed rather
easily.
Cheers Nick 

On 2014-12-18 08:39 AM, Lucas Stach wrote:
> Am Donnerstag, den 18.12.2014, 08:35 -0500 schrieb nick:
>> Krzysztof,
>> If we look at the code for this function, it already is handling the data correctly. In addition  the locks 
>> seem to be better protection then msleep. Further more is no reason for this delay as we are neither resetting 
>> the hardware or waiting for the hardware here so why is it needed? I don't have Exynos based hardware lying
>> around through to test it.
> 
> If you can't test it, don't touch it. It's that simple.
> 
> Regards,
> Lucas
> 
