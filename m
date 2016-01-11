From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 11 Jan 2016 11:12:22 +0000
Subject: [PATCH] arm64: Add DT support for Juno r2 board
In-Reply-To: <20160111110909.GD13633@e106497-lin.cambridge.arm.com>
References: <1450872611-15326-1-git-send-email-sudeep.holla@arm.com>
 <20151229183521.GL12450@rob-hp-laptop> <5683BE7A.9020404@arm.com>
 <CAL_Jsq+RZk3LnOhGtiXRFmxmA6bTOEdymtF1yN=6q=iRmUr_9Q@mail.gmail.com>
 <5683F971.9000300@arm.com>
 <20160111110909.GD13633@e106497-lin.cambridge.arm.com>
Message-ID: <56938E16.5090402@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/01/16 11:09, Liviu Dudau wrote:
> On Wed, Dec 30, 2015 at 03:34:09PM +0000, Sudeep Holla wrote:

[...]

>>>>
>>>> AFAIK it is. Liviu can you confirm ?
>>>
>>> Then perhaps you should move this to a common spot.
>>>
>>
>> True, will wait for Liviu's response.
>
> AFAIK Juno r2 should have identical PCIe controller to r1. I have not been able to
> test it myself but at the same time I have no information on any changes applied to
> the IP.
>
> Sudeep, probably worth moving the pcie-controller at 40000000 node in juno-base.dtsi
> and disable it by default, then re-enable in juno-r1.dts and juno-r2.dts.
>

Yes, that's exactly what I though as it's present even on R0 but
disabled due to H/W bug. I will do that and repost after merge window.

-- 
Regards,
Sudeep
