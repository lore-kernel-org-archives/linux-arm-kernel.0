From: lho@apm.com (Loc Ho)
Date: Wed, 15 Jan 2014 13:08:47 -0800
Subject: [PATCH v9 2/4] Documentation: Add documentation for APM X-Gene
 SoC SATA host controller DTS binding
In-Reply-To: <5905127.tqJ3nFt5cj@wuerfel>
References: <1389769910-15505-1-git-send-email-lho@apm.com>
 <20140115111839.GB25824@e106331-lin.cambridge.arm.com>
 <CAPw-ZT=wJVQ2Qw47Ehgu6rJZ4HkpADrGuhZr8Yjf4XA6z+-xbA@mail.gmail.com>
 <5905127.tqJ3nFt5cj@wuerfel>
Message-ID: <CAPw-ZTmVYfPLUVmtes3Gn8Z=+gyFtLoZxc-QUdHH7-ePjKAG9A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>>
>> >> +- clocks             : Reference to the clock entry.
>> >> +- phys                       : PHY reference with parameter 0.
>> >
>> > The specific value of the phy-specifier shouldn't matter to this
>> > binding. What should matter is what it logically corresponds to.
>>
>> I not quite following this. Are you suggest that I drop the value 0.
>> In the binding, one needs to specify the mode of operation - 0 is for
>> SATA. Can you explain more?
>
> The SATA device should not care what the argument for the PHY
> device is. You could connect the same device to another PHY
> that has a different set of arguments, which is the whole point
> of abstracting it.
>

I understand what you wrote here. We should not have an argument from
the host controller. Then my question is how should the PHY node
indicates that it needs to be configured itself as an SATA PHY?

-Loc
