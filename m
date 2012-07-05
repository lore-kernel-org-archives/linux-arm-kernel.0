From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 05 Jul 2012 16:50:42 +0100
Subject: [PATCH] of: address: Don't fail a lookup just because a node
 has no reg property
In-Reply-To: <201207051538.37687.arnd@arndb.de>
References: <1341498754-30445-1-git-send-email-lee.jones@linaro.org>
 <4FF5AB4D.6090500@gmail.com> <4FF5B004.4080100@linaro.org>
 <201207051538.37687.arnd@arndb.de>
Message-ID: <4FF5B7D2.8000909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/12 16:38, Arnd Bergmann wrote:
> On Thursday 05 July 2012, Lee Jones wrote:
>>>
>>> Acked-by: Rob Herring <rob.herring@calxeda.com>
>>>
>>> Do you have something dependent on this or want me to apply?
>>
>> I have things that require this patch yes. Please apply.
>
> I guess Rob's question was whether you want to keep this together
> with the patch that depends on it rather than him applying just
> the one patch.

No, it's not important.

I'll send you the other patch as part of my DT pull-request.

I'm just waiting on Linus' Ack on a few patches and it'll be ready.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
