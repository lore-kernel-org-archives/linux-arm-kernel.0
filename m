From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 25 Feb 2014 15:17:05 +0100
Subject: [PATCH 0/2] ARM: SAMSUNG: move all arches to generic uncompress.h
In-Reply-To: <3594365.ORKU4Q2jDp@phil>
References: <3594365.ORKU4Q2jDp@phil>
Message-ID: <3158811.UU2ZyPShVi@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 16. Februar 2014, 18:32:24 schrieb Heiko St?bner:
> On 2014-01-06 Sachin Kamat posted two patches converting Exynos to use
> the generic uncompress.h.
> 
> But in fact all Samsung platforms can go this route, as all Samsung
> uncompress.h files are simply used to set up the serial port.
> 
> As the original patches were not yet applied, this series includes the
> original Exynos-specific change.
> 
> Tested on a s3c2416 and s3c2442 based machine.

ping?


Thanks
Heiko
