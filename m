From: robherring2@gmail.com (Rob Herring)
Date: Fri, 17 May 2013 14:23:34 -0500
Subject: ux500 breaking multi-platform kernels
In-Reply-To: <CACRpkdbJosO7Ea8=BUdgVSf5fZwddWZb79ONaz3r+DqseAaF7Q@mail.gmail.com>
References: <CAL_JsqJzf8Aj6+K_qEYo3JbAoeJn36EerBfaGYT9EQj-zPaHUw@mail.gmail.com>
 <CACRpkdbJosO7Ea8=BUdgVSf5fZwddWZb79ONaz3r+DqseAaF7Q@mail.gmail.com>
Message-ID: <CAL_JsqLRXh9AW9fPy9YkAufzY5cV8=FmRU_O346EQixb=YAW3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 1:29 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, May 15, 2013 at 10:30 PM, Rob Herring <robherring2@gmail.com> wrote:
>
>> There are some initcalls on ux500 that are not properly
>> conditionalized.
>
> Oh wow you actually compiled it in and tried to boot it on something
> else :-D
>
> Highbank I suppose?
>
>> The first is in ux500_l2x0_init and here is a fix:
>
> I guess this is all -rc material. Can you send a proper patch (set)?

It is. I don't really think this is the ideal fix. It would be better
if you could make this not be an unconditional initcall.

Rob
