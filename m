From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 04 Dec 2013 00:30:35 +0800
Subject: [RFC part3 PATCH 2/2] ARM64 / clocksource: Use
 arch_timer_acpi_init()
In-Reply-To: <20131203144309.GC7552@e106331-lin.cambridge.arm.com>
References: <1386069328-22502-1-git-send-email-hanjun.guo@linaro.org>
 <1386069328-22502-3-git-send-email-hanjun.guo@linaro.org>
 <CACRpkdYeMOMQzDn5=XpDg7X9L_zMZczGg-5SBA8q_WvwFPnH7A@mail.gmail.com>
 <529DE21E.4080707@linaro.org>
 <CACRpkdZWELp1u=O=gSGZhaxQ2oTMu_jXuJb43snrr-tdYW9XAA@mail.gmail.com>
 <20131203144309.GC7552@e106331-lin.cambridge.arm.com>
Message-ID: <529E072B.3060901@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013?12?03? 22:43, Mark Rutland wrote:
> On Tue, Dec 03, 2013 at 02:13:49PM +0000, Linus Walleij wrote:
>> On Tue, Dec 3, 2013 at 2:52 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>>
>>> I will introduce has_arch_timer_node() as you said and use
>>> it as follows:
>>>
>>> if (has_arch_timer_node())
>>> clocksource_of_init();
>>> esle
>>> arch_timer_acpi_init(); /* try ACPI way */
>>>
>>> Is this make sense to you?
> What does arch_timer_acpi_init() do? Is it just detecting the presence
> of the timer, or grabbing the rate from a property in an ACPI table?

It seems that you didn't get the PATCH 1/2, and my part1/part2 patch set
is also missing, I will resend all the patch set, sorry for the noise.

Thanks
Hanjun
