From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sat, 11 Mar 2017 18:27:00 +0100
Subject: [PATCH] ARM: dts: BCM5301X: Add support for TP-LINK Archer C5 V2
In-Reply-To: <20170311172309.GC15842@lunn.ch>
References: <20170311121453.18534-1-zajec5@gmail.com>
 <20170311172309.GC15842@lunn.ch>
Message-ID: <CACna6rzxaqnLShMQRovv4Cr5s6XKSG0NQ2RRrQ+TeePt59bG7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On 11 March 2017 at 18:23, Andrew Lunn <andrew@lunn.ch> wrote:
> On Sat, Mar 11, 2017 at 01:14:53PM +0100, Rafa?? Mi??ecki wrote:
>> From: Rafa?? Mi??ecki <rafal@milecki.pl>
>>
>> This is BCM47081A0 based home router with BCM43217 and BCM4352 wireless
>> chipsets.
>
> Have you made any progress with the Ethernet switch? Does anybody know
> if it is compatible with the SF2/B53 DSA driver?
>
> I have a DIR 860l v1 router, using the same chipset. I'm interested in
> the switch, given my DSA maintainer role.

I mostly work with LEDE. Just few days ago I managed get kernel 4.9
running stable (there was a memory corruption caused by iproc PCIe
controller driver). With kernel 4.9 I can finally start testing b53. I
should have some news withing new weeks.

-- 
Rafa?
