From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 21 Feb 2017 12:51:49 +0800
Subject: [PATCH v3 05/18] mfd: axp20x: add ADC cells for AXP20X and AXP22X
 PMICs
In-Reply-To: <20170215093701.k33jmzeu4xz5guet@dell>
References: <20170214094112.27426-1-quentin.schulz@free-electrons.com>
 <20170214094112.27426-6-quentin.schulz@free-electrons.com>
 <20170215093701.k33jmzeu4xz5guet@dell>
Message-ID: <CAGb2v64zeOG+JtifgtdtxDMvi=+i6aeJ9_5UqghqB2oeBTjA3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 15, 2017 at 5:37 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 14 Feb 2017, Quentin Schulz wrote:
>
>> This adds the AXP20X/AXP22x ADCs driver to the mfd cells of the AXP209,
>> AXP221 and AXP223 MFD.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>
>> v3:
>>  - removed of_compatible as DT node has been removed,
>>  - use different names to probe the ADC driver,
>>
>>  drivers/mfd/axp20x.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>
> For my own reference:
>   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
