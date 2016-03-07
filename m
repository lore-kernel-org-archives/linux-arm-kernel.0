From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 7 Mar 2016 13:35:31 +0100
Subject: [PATCH v3 0/8] arm64: rockchip: Initial GeekBox enablement
In-Reply-To: <2714888.1DdqvJZ8cb@diego>
References: <1457294038-14243-1-git-send-email-afaerber@suse.de>
 <56DD7172.4000707@suse.de> <2714888.1DdqvJZ8cb@diego>
Message-ID: <56DD7593.5060003@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

Am 07.03.2016 um 13:24 schrieb Heiko St?bner:
> Am Montag, 7. M?rz 2016, 13:17:54 schrieb Andreas F?rber:
>> Am 06.03.2016 um 20:53 schrieb Andreas F?rber:
>>> On next-20160304 the GMAC seems to have regressed, it no longer finds the
>>> PHY:
>>>
>>> libphy: PHY stmmac-0:ffffffff not found
>>> eth0: Could not attach to PHY
>>> stmmac_open: Cannot attach to PHY (error: -19)
>>
>> Still with us in next-20160307. CC'ing stmmac maintainers.
> 
> do you remember from what revision you rebased away from, when it was still 
> working (as a known-good state)?

Hm, next-20160111 possibly... leaving all the 5 days and 4 days ago
changes as candidates ("stmmac: share reset function between dwmac100
and dwmac1000" .. "stmmac: Fix 'eth0: No PHY found' regression").

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
