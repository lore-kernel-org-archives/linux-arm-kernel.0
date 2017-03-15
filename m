From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 15 Mar 2017 15:15:28 +0200
Subject: [PATCH v4 4/5] mfd: exynos-lpass: Use common soc/exynos-regs-pmu.h
 header
In-Reply-To: <20170315121212.p2xu64dzhrzmjbxv@dell>
References: <20170314164653.15771-1-krzk@kernel.org>
 <20170314164653.15771-5-krzk@kernel.org>
 <20170315101007.xtnwz7mmkt446sgd@dell>
 <CAJKOXPeFw-qRcznSvw-+ZYxObXTPjE4bRM37=sGf8aWbR31WEg@mail.gmail.com>
 <20170315121212.p2xu64dzhrzmjbxv@dell>
Message-ID: <CAJKOXPfZv5yVMHV2wQfgPp8Vy8aQvq_DartX_hPG5jG4U_Mn7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 2:12 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 15 Mar 2017, Krzysztof Kozlowski wrote:
>
>> On Wed, Mar 15, 2017 at 12:10 PM, Lee Jones <lee.jones@linaro.org> wrote:
>> > On Tue, 14 Mar 2017, Krzysztof Kozlowski wrote:
>> >
>> >> The MFD-specific header will go away because it duplicates defines from
>> >> exynos-regs-pmu.h.
>> >>
>> >> Reported-by: kbuild test robot <fengguang.wu@intel.com>
>> >> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> >> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> >> ---
>> >>  drivers/mfd/exynos-lpass.c | 4 ++--
>> >>  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > Applied, thanks.
>>
>> Hi,
>>
>> This is also needed for patch 5/5 in the set so I was wondering if
>> this can be put on separate branch and then shared if phy maintainers
>> would need it?
>
> What is the dependency?

This patch removes the last usage of define from header we want to
remove (linux/mfd/syscon/exynos5-pmu.h). The next patch (5/5) removes
the header as there are no more users.

BTW, I hope you got all the mails from this patchset including cover letter.

Best regards,
Krzysztof
