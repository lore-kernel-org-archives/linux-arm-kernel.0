From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 11 Mar 2017 13:05:11 -0800
Subject: [PATCH] ARM: dts: BCM5301X: Add support for TP-LINK Archer C5 V2
In-Reply-To: <CACna6rzxaqnLShMQRovv4Cr5s6XKSG0NQ2RRrQ+TeePt59bG7A@mail.gmail.com>
References: <20170311121453.18534-1-zajec5@gmail.com>
 <20170311172309.GC15842@lunn.ch>
 <CACna6rzxaqnLShMQRovv4Cr5s6XKSG0NQ2RRrQ+TeePt59bG7A@mail.gmail.com>
Message-ID: <855bc957-8a04-47d6-3355-b641c8f393ad@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/11/2017 09:27 AM, Rafa? Mi?ecki wrote:
> Hi Andrew,
> 
> On 11 March 2017 at 18:23, Andrew Lunn <andrew@lunn.ch> wrote:
>> On Sat, Mar 11, 2017 at 01:14:53PM +0100, Rafa?? Mi??ecki wrote:
>>> From: Rafa?? Mi??ecki <rafal@milecki.pl>
>>>
>>> This is BCM47081A0 based home router with BCM43217 and BCM4352 wireless
>>> chipsets.
>>
>> Have you made any progress with the Ethernet switch? Does anybody know
>> if it is compatible with the SF2/B53 DSA driver?
>>
>> I have a DIR 860l v1 router, using the same chipset. I'm interested in
>> the switch, given my DSA maintainer role.
> 
> I mostly work with LEDE. Just few days ago I managed get kernel 4.9
> running stable (there was a memory corruption caused by iproc PCIe
> controller driver). With kernel 4.9 I can finally start testing b53. I
> should have some news withing new weeks.

FYI, the initial b53 work was done by testing on:
- BCM53010 (SR400AC) and BCM53012 (BCM953012ER)
- BCM58265 (Northstar Plus)
- externally attached BCM53125 to a BCM7445

So let me know if you need guidance/help with getting the 4708/5301X
devices to work.
-- 
Florian
