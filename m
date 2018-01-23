From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 23 Jan 2018 23:32:23 +0800
Subject: [PATCH v3 06/16] mfd: axp20x: make AXP209/22x cells probe their
 ADC via DT
In-Reply-To: <20180123095408.zin3tcxf37j2wu7i@dell>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
 <8901f920fb8d84f8bf0cb2832f560c78bffc0392.1516012352.git-series.quentin.schulz@free-electrons.com>
 <20180123095408.zin3tcxf37j2wu7i@dell>
Message-ID: <CAGb2v67Cd9BM9t0H6P9=m0-rtYTFy2-py8SGQX+Tmtpo91zMxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 5:54 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 15 Jan 2018, Quentin Schulz wrote:
>
>> This makes AXP209 and AXP22x ADCs probe first via DT and then by
>> fallback via platform.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>  drivers/mfd/axp20x.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
