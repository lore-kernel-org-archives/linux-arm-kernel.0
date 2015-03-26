From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 26 Mar 2015 11:38:33 +0000
Subject: [PATCH 07/13] clocksource: tcb_clksrc: make IO endian agnostic
In-Reply-To: <5513E8A1.1050809@atmel.com>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <1426693992-31163-8-git-send-email-ben.dooks@codethink.co.uk>
 <5513D7AA.8030008@linaro.org> <5513E8A1.1050809@atmel.com>
Message-ID: <5513EFB9.702@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/03/15 11:08, Nicolas Ferre wrote:
> Le 26/03/2015 10:55, Daniel Lezcano a ?crit :
>> On 03/18/2015 04:53 PM, Ben Dooks wrote:
>>> Change the __raw read and write to use readl/writel_relaxed to make the
>>> code endian agnostic.
>>>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>>
>> Nicolas,
>>
>> what about this one ? Do you ack it ?
> 
> Yes:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> We were discussing about having a common macro for this... But we will
> think more about it later.
> 
> So, let's go for it.

I will be sending out a series for this soon, I think I've got all
the items sorted.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
