From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Jan 2015 13:28:20 +0100
Subject: [PATCH] pinctrl: fix up device tree bindings
In-Reply-To: <CAL_JsqKQJzUOWE2oJsABH3Aa1cCD+526L0G7-WRH=LbKFxesyQ@mail.gmail.com>
References: <1420924457-12730-1-git-send-email-linus.walleij@linaro.org>
 <CAL_JsqKQJzUOWE2oJsABH3Aa1cCD+526L0G7-WRH=LbKFxesyQ@mail.gmail.com>
Message-ID: <CACRpkda9YXi2MJnC_r_CWcfHM7i10oZ2d6VZUQnkix9r_M8fhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 9:06 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Sat, Jan 10, 2015 at 3:14 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> After the Nomadik pin controller was force migrated to generic pin
>> control bindings, some leftovers in the documentation need to be
>> cleaned up. The code and device trees are already migrated.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> Applied for 3.20. Thanks.

Oh thanks! :)

I was thinking I'd take it through the pinctrl tree but the
DT tree is even better.

Yours,
Linus Walleij
