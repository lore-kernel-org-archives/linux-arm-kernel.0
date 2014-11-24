From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 24 Nov 2014 12:08:15 +0100
Subject: [RFC 0/4] vgic additions for forwarded irq
In-Reply-To: <54730E6C.1040708@arm.com>
References: <1416766373-13569-1-git-send-email-eric.auger@linaro.org>
 <20141124105037.GL3401@cbox> <54730E6C.1040708@arm.com>
Message-ID: <5473119F.5060707@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2014 11:54 AM, Marc Zyngier wrote:
> On 24/11/14 10:50, Christoffer Dall wrote:
>> On Sun, Nov 23, 2014 at 07:12:49PM +0100, Eric Auger wrote:
>>> This series applies on top of "ARM: Forwarding physical
>>> interrupts to a guest VM" (http://lwn.net/Articles/603514/)
>>> series.
>>
>> Marc and Eric,
>>
>> Does it make sense to review and look at these patches given the current
>> state of the forwarding patches, or should we wait until Marc respins
>> that series?
> 
> I'm still in the process of respining all of this (we've had a few
> iterations with tglx, but I got sidetracked with the ITS/v2m/MSI side of
> things).

Hi Marc, Christoffer,

for your info, I integrated with kvm-arm64/irq-forward branch prior to
ITS integration, not with the RFC.

Best Regards

Eric

> 
> I'll get back onto this this week. Hopefully.
> 
> Thanks,
> 
> 	M.
> 
