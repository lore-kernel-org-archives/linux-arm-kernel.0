From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 11 Feb 2016 14:28:58 +0100
Subject: [PATCH v2] pinctrl: sunxi: H3 requires irq_read_needs_mux
In-Reply-To: <CAGb2v65ZTBQZhFvesHPdwXDbwuVWcOQ+KUu82DWae6K8ycAxMA@mail.gmail.com>
References: <20160203075713.GA23312@box2.japko.eu>
 <CACRpkdbVtLYRku03bbnT=f7Ex1FoJqBv4Z6nY7pWkHy6wvHUfg@mail.gmail.com>
 <CAGb2v65ZTBQZhFvesHPdwXDbwuVWcOQ+KUu82DWae6K8ycAxMA@mail.gmail.com>
Message-ID: <CACRpkdZ3Spw3+bz1=ou-f4JurSvFWMbPPZBz3gA2BkTbMs4eaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 5, 2016 at 2:51 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Fri, Feb 5, 2016 at 9:39 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> On Wed, Feb 3, 2016 at 8:57 AM, Krzysztof Adamski <k@japko.eu> wrote:
>>
>>> It seems that on H3, just like on A10, when GPIOs are configured as
>>> external interrupt data registers does not contain their value.  When
>>> value is read, GPIO function must be temporary switched to input for
>>> reads.
>>>
>>> Signed-off-by: Krzysztof Adamski <k@japko.eu>
>>
>> 1. Waiting for Maxime's ACK on this patch.
>
> Maxime already acked v1.
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
>
>> 2. Is this a regression that need to go in to fixes?
>
> This driver was introduced in 4.5-rc1. It'd be nice if this fix could make
> it in 4.5. :)

OK ooops merged the v1 version, undoing and merging this version
instead.

Yours,
Linus Walleij
