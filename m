From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 23 Jan 2018 23:32:46 +0800
Subject: [PATCH v3 09/16] mfd: axp20x: probe axp20x_adc driver for AXP813
In-Reply-To: <20180123095305.lgxpq5gyzlo5cked@dell>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
 <d5792ed6e1e989dde3c9ecdd018286109dfc101d.1516012352.git-series.quentin.schulz@free-electrons.com>
 <20180123095305.lgxpq5gyzlo5cked@dell>
Message-ID: <CAGb2v67gba1i=g3t7sTscOp690xLMceiGNed_60f6FRORk9MQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 23, 2018 at 5:53 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 15 Jan 2018, Quentin Schulz wrote:
>
>> This makes the axp20x_adc driver probe with platform device id
>> "axp813-adc".
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>  drivers/mfd/axp20x.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
