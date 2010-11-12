From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 12 Nov 2010 12:36:32 +0900
Subject: [PATCH] ARM: Common GIC entry macro code V2
In-Reply-To: <20101112004212.GZ9264@atomide.com>
References: <20101111074955.29633.80160.sendpatchset@t400s>
	<20101112004212.GZ9264@atomide.com>
Message-ID: <AANLkTim=imRKsewon5NJoDe3=4s-OhuhmxbAvN1ALhSH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Fri, Nov 12, 2010 at 9:42 AM, Tony Lindgren <tony@atomide.com> wrote:
> Hi Magnus,
>
> * Magnus Damm <magnus.damm@gmail.com> [101110 23:37]:
>>
>> The omap code is excluded due to complexity and lack of
>> hardware - the CONFIG_SMP macros are used for multi-omap
>> and the omap4 case - this makes is difficult to share code.
>
> Hmm test_for_ipi and test_for_ltirq are needed for the
> SMP_ON_UP case, so I've moved those in to the MULTI_OMAP2
> section.

Looking good!

> Maybe merge the following into your original patch?

Sure, I'll include your code as a broken out patch in V3.

Thank you!

/ magnus
