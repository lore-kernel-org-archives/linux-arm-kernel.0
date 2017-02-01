From: eric@anholt.net (Eric Anholt)
Date: Wed, 01 Feb 2017 11:51:51 -0800
Subject: [PATCH] MAINTAINERS: extend Raspberry Pi entry
In-Reply-To: <2fcb0690-861a-1b83-c6d5-dfdef03fa9ab@wwwdotorg.org>
References: <b2e1e59a752395314a20e846337cb70cf22f2959.1485720503.git.baruch@tkos.co.il>
 <736209d7-5310-ac2f-1ff7-928b978e665e@wwwdotorg.org>
 <87zii7xb66.fsf@eliezer.anholt.net>
 <2fcb0690-861a-1b83-c6d5-dfdef03fa9ab@wwwdotorg.org>
Message-ID: <87h94dr8o8.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 01/31/2017 12:49 PM, Eric Anholt wrote:
>> Stephen Warren <swarren@wwwdotorg.org> writes:
>>
>>> On 01/29/2017 01:08 PM, Baruch Siach wrote:
>>>> Add bcm2836 (Raspberry Pi 2) and bcm2837 (Raspberry Pi 3).
>>>
>>>> -BROADCOM BCM2835 ARM ARCHITECTURE
>>>> +BROADCOM BCM2835/BCM2836/BCM2837 ARM ARCHITECTURE
>>> ...
>>>>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rpi/linux-rpi.git
>>>
>>> It would make sense to update that too, if Eric isn't using this.
>>> However, that's a subject for a different patch perhaps.
>>>
>>> Acked-by: Stephen Warren <swarren@wwwdotorg.org>
>>
>> Pulled this patch, sent a followup for the tree location.
>>
>> Thinking of MAINTAINERS, I was wondering if you and Lee were both still
>> interested in being on the list?
>
> To be honest, I was thinking about sending a patch to remove myself 
> since you've been taking care of everything well and I've been too lazy 
> to do anything RPi related recently.

Sounds good.

I've been mulling over a couple of ideas about bcm2835 maintainership of
the tree since LCA: one is asking Florian if he'd like me to just be a
co-maintainer with a limited role within the stblinux tree (bcm2835 is
pretty low traffic, I don't see the need for a separate tree), and the
other is picking up one of the more active current Pi developers as a
co-maintainer within the current tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170201/a05e6cb6/attachment.sig>
