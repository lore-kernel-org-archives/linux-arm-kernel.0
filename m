From: cjb@laptop.org (Chris Ball)
Date: Wed, 18 Apr 2012 11:20:03 -0400
Subject: [PATCH 7/7] MMC: mmci: Add required documentation for Device Tree
 bindings
In-Reply-To: <4F8ED9E1.8060604@linaro.org> (Lee Jones's message of "Wed, 18
 Apr 2012 16:12:33 +0100")
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
 <1334325909-5779-8-git-send-email-lee.jones@linaro.org>
 <1334759484.26922.11.camel@hornet> <4F8ED9E1.8060604@linaro.org>
Message-ID: <874nshnk2k.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Apr 18 2012, Lee Jones wrote:
> On 18/04/12 15:31, Pawel Moll wrote:
>> On Fri, 2012-04-13 at 15:05 +0100, Lee Jones wrote:
>>> +Required properties:
>>> +- arm,primecell-periphid : contains the PrimeCell Peripheral ID.
>>
>> I'd say that this is _very_ optional (as in: don't use this, unless you
>> know what are you doing ;-)
>
> Okay.
>
> Who is pulling this patch by the way? Chris is it you?

Russell King is maintaining MMCI (although I don't think MAINTAINERS has
caught up with that yet) -- it would be ideal for me if you could get an
ACK from him so that I can merge it to mmc-next and send it to Linus.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
