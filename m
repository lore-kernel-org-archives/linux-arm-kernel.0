From: ivo.g.dimitrov.75@gmail.com (Ivaylo Dimitrov)
Date: Thu, 24 Dec 2015 21:02:41 +0200
Subject: [PATCH 1/2] ARM: ATAGS: move save_atags() to include/asm
 arch/arm/include/asm/setup.h
In-Reply-To: <20151224185319.GT2793@atomide.com>
References: <20151224153536.GJ30871@n2100.arm.linux.org.uk>
 <1450975076-7411-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1450975076-7411-2-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <201512241848.17946@pali> <20151224185319.GT2793@atomide.com>
Message-ID: <567C4151.2090003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24.12.2015 20:53, Tony Lindgren wrote:
> * Pali Roh?r <pali.rohar@gmail.com> [151224 09:48]:
>> On Thursday 24 December 2015 17:37:55 Ivaylo Dimitrov wrote:
>>> So it can be used by code outside arch/arm/kernel/. Fix save_atags()
>>> declaration to match its definition while at it.
>>>
>>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>>
>> Tested-by: Pali Roh?r <pali.rohar@gmail.com>
>
> Nice, please upload both to Russell's patch system after no
> more comments:
>
> Acked-by: Tony Lindgren <tony@atomide.com>
>

Hi Tony,

Could you elaborate on that patch system? Where it is and do I need some 
special account/access?

Regards,
Ivo
