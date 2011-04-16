From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sat, 16 Apr 2011 16:00:39 +0200
Subject: Could I (ab)use bus (struct bus_type) for virtual Broadcom bus?
In-Reply-To: <20110415195642.22440.qmail@stuge.se>
References: <1302781431.21145.6.camel@dev.znau.edu.ua>
	<BANLkTinvpt5vs+rXd3WN-a2JpGtTV+=Gyg@mail.gmail.com>
	<4DA6E9BD.3090404@hauke-m.de>
	<BANLkTinu+Q367oqQPiUehPcbMs-SBxbwFg@mail.gmail.com>
	<1302786900.21965.52.camel@dev.znau.edu.ua>
	<BANLkTimM8=-pX+Ea8Eyp4XyvP1APbUof9w@mail.gmail.com>
	<1302892585.30441.12.camel@dev.znau.edu.ua>
	<BANLkTi=16i+D8frz3X2f+JDtp4hbJKLL3A@mail.gmail.com>
	<1302896541.30441.33.camel@dev.znau.edu.ua>
	<BANLkTinPVaYC14Y=m5iu7GYodkRb6uTuPw@mail.gmail.com>
	<20110415195642.22440.qmail@stuge.se>
Message-ID: <BANLkTinNoX6GBG=6xVC8ZfOO4OyZ_o=sFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/15 Peter Stuge <peter@stuge.se>:
> Rafa? Mi?ecki wrote:
>> > On other hand just broadcom-specific bus looks like good alternative
>> > too but here I just fail to decide on relevant naming.
>>
>> Just bcmamba / bcmaxi?
>
> Do bcm make any other (different) busses that would warrant a more
> specific name, hinting somehow at the wireless cards specifically?
>
> Or is it just cool to have a short name? Me I always like short names.

I don't think Broadcom is going to publish new cards based on AMBA
with totally different cores discovery, agent (wrapper) programming,
etc. However of course we never know that and I think Broadcom does
not as well.

Of the other point there is no sense in calling it
bcm_amba_axi_for_wifi as I believe we can meet other devices than just
wifi on this architecture. So let's just call it bcmamba and there is
not other much better solution. If in the future we will hit some
problems we can always try some renaming, aliasing... we will see.

-- 
Rafa?
