From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 18 Apr 2012 16:25:33 +0100
Subject: [PATCH 7/7] MMC: mmci: Add required documentation for Device
 Tree bindings
In-Reply-To: <874nshnk2k.fsf@laptop.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-8-git-send-email-lee.jones@linaro.org>
 <1334759484.26922.11.camel@hornet> <4F8ED9E1.8060604@linaro.org>
 <874nshnk2k.fsf@laptop.org>
Message-ID: <4F8EDCED.5010404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/04/12 16:20, Chris Ball wrote:
> Hi,
>
> On Wed, Apr 18 2012, Lee Jones wrote:
>> On 18/04/12 15:31, Pawel Moll wrote:
>>> On Fri, 2012-04-13 at 15:05 +0100, Lee Jones wrote:
>>>> +Required properties:
>>>> +- arm,primecell-periphid : contains the PrimeCell Peripheral ID.
>>>
>>> I'd say that this is _very_ optional (as in: don't use this, unless you
>>> know what are you doing ;-)
>>
>> Okay.
>>
>> Who is pulling this patch by the way? Chris is it you?
>
> Russell King is maintaining MMCI (although I don't think MAINTAINERS has
> caught up with that yet) -- it would be ideal for me if you could get an
> ACK from him so that I can merge it to mmc-next and send it to Linus.

Ideal, thanks Chris.

Russell is CC'ed, so hopefully he'll come across it soon.

Kind regards,
Lee

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
