From: Nathan_Lynch@mentor.com (Nathan Lynch)
Date: Tue, 1 Jul 2014 09:56:44 -0500
Subject: [PATCH CFT 00/30] Initial round of Freescale FEC ethernet patches
In-Reply-To: <20140701143401.GT32514@n2100.arm.linux.org.uk>
References: <20140627151542.GL32514@n2100.arm.linux.org.uk>
 <53B2C3E8.7030903@mentor.com> <20140701143401.GT32514@n2100.arm.linux.org.uk>
Message-ID: <53B2CC2C.7080306@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/01/2014 09:34 AM, Russell King - ARM Linux wrote:
> On Tue, Jul 01, 2014 at 09:21:28AM -0500, Nathan Lynch wrote:
>> [apologies if this is a duplicate, I got a weird SMTP error from my
>> organization's mail server when I tried to send this yesterday]
>>
>> On 06/27/2014 10:15 AM, Russell King - ARM Linux wrote:
>>> This is v2 of my initial round of patches (roughly half of my total
>>> patch set) for the Freescale FEC driver.
>>>
>>> I'm sending this set out for comments and testing.  So far, I have
>>> had only one ack for one patch in this series, this is pretty poor,
>>> so I'm now sending it with a CFT tag instead.
>>
>> FWIW I've given your fec-testing branch some testing on BD-SL-i.MX6
>> (Sabre Lite) with 3.16-rc2 (-rc1 has some issue with detecting the mmc).
>>  Mainly running glibc 'make check' with SSH, NFSv4, IPv4 on a gigabit
>> switch.  This workload wasn't exhibiting problems before your patches
>> and it does not appear to be regressed by them.
>>
>> I wanted to test it because I've noticed hard-to-characterize sluggish
>> interactive response in SSH sessions on this system.  Like key echo
>> takes 0.2 seconds too long... sometimes.  I guess it could be anything,
>> but I haven't encountered it yet with your patches.
> 
> Thanks for testing.
> 
> Can I add a tested-by tag for you for those patches?

Of course.

Tested-by: Nathan Lynch <nathan_lynch@mentor.com>
