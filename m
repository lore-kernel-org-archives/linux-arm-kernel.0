From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 15 Mar 2017 13:02:51 +0200
Subject: [PATCH v4 4/5] mfd: exynos-lpass: Use common soc/exynos-regs-pmu.h
 header
In-Reply-To: <20170315101007.xtnwz7mmkt446sgd@dell>
References: <20170314164653.15771-1-krzk@kernel.org>
 <20170314164653.15771-5-krzk@kernel.org>
 <20170315101007.xtnwz7mmkt446sgd@dell>
Message-ID: <CAJKOXPeFw-qRcznSvw-+ZYxObXTPjE4bRM37=sGf8aWbR31WEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 15, 2017 at 12:10 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 14 Mar 2017, Krzysztof Kozlowski wrote:
>
>> The MFD-specific header will go away because it duplicates defines from
>> exynos-regs-pmu.h.
>>
>> Reported-by: kbuild test robot <fengguang.wu@intel.com>
>> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
>> ---
>>  drivers/mfd/exynos-lpass.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Applied, thanks.

Hi,

This is also needed for patch 5/5 in the set so I was wondering if
this can be put on separate branch and then shared if phy maintainers
would need it?

Best regards,
Krzysztof
