From: jonathan.austin@arm.com (Jonathan Austin)
Date: Mon, 29 Jul 2013 12:01:02 +0100
Subject: [PATCH 2/2] clk: fixup argument order when setting VCO parameters
In-Reply-To: <20130725174416.7598.73819@quantum>
References: <1374594138-17080-1-git-send-email-jonathan.austin@arm.com>
 <1374594138-17080-3-git-send-email-jonathan.austin@arm.com>
 <CACRpkdbEiNPG0b89zXKpvNgXtAbsKeV9A9ibgEJCBgNa6vQvCw@mail.gmail.com>
 <51F0F035.8010705@arm.com> <20130725174416.7598.73819@quantum>
Message-ID: <51F64B6E.4070300@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/07/13 18:44, Mike Turquette wrote:
> Quoting Jonathan Austin (2013-07-25 02:30:29)
>> On 24/07/13 20:32, Linus Walleij wrote:
>>> On Tue, Jul 23, 2013 at 5:42 PM, Jonathan Austin
>>> <jonathan.austin@arm.com> wrote:
>>>
>>>> The order of arguments in the call to vco_set() for the ICST clocks appears to
>>>> have been switched in error, which results in the VCO not being initialised
>>>> correctly. This in turn stops the integrated LCD on things like Integrator/CP
>>>> from working correctly.
>>>>
>>>> This patch fixes the order and restores the expected functionality.
>>>>
>>>> Cc: Linus Walleij <linus.walleij@linaro.org>
>>>> Cc: Mike Turquette <mturquette@linaro.org>
>>>> Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
>>>
>>> Good catch! Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>> You should probably mark this for stable as well.
>>>
>>
>> Mike, will you add Cc: stable when you take the fix or shall I resubmit
>> the patch somehow else?
>
> I'll add it.
>

Thanks very much.

Linus or Mike: Should I put 1/2 in this series in to Russell's tree, or 
should that go in elsewise?

Jonny
