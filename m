From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Jan 2017 08:04:54 +0100
Subject: [PATCH] ARM: defconfig: include QCOM_EBI2 in multi_v7
In-Reply-To: <cee567ef-adc3-eb3f-81bb-e8a678b35fa8@codeaurora.org>
References: <20170110100931.15791-1-linus.walleij@linaro.org>
 <CAOesGMh-5oyzjsby=R9c=euAngsq9=cNwJFDhEEKWtzxoqzLKA@mail.gmail.com>
 <CACRpkdacU0X1NH5HRwTvt1Wtn=9iqEs0MYQ_vt4UsGV67S4kBA@mail.gmail.com>
 <cee567ef-adc3-eb3f-81bb-e8a678b35fa8@codeaurora.org>
Message-ID: <CACRpkdZt+8K+R4p5zyHirMFU-RdBQ1Q+-3EHWc31t5s-sgyNyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 12, 2017 at 2:01 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 01/11/2017 07:22 AM, Linus Walleij wrote:
>> On Tue, Jan 10, 2017 at 7:02 PM, Olof Johansson <olof@lixom.net> wrote:
>>> On Tue, Jan 10, 2017 at 2:09 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>>> This adds the Qualcomm External Bus Interface 2 to the multi_v7
>>>> defconfig: it is hard for users to realize that this is a
>>>> required driver for getting things like ethernet, and a necessary
>>>> prerequisite to get the external bus discoverable on the
>>>> MSM8660/APQ8060 machines.
>>> Is it the kind of option that should really be selected through
>>> Kconfig instead for those platforms?
>>
>> Stephen Boyd question.
>>
>> AFAIK the ambition is to go with the platform to have zero
>> stuff in mach-qcom/* and thus it all becomes a defconfig
>> thing.
>
> It could be made a 'default ARCH_QCOM' type of thing. Then the config
> doesn't need an update unless you want to turn it off.

OK I will do that.

Olof: let's scrap this patch.

Yours,
Linus Walleij
