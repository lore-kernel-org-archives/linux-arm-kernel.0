From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Thu, 26 Jul 2018 17:40:32 +0530
Subject: [PATCH v7 4/6] dt-bindings: mailbox: imx-mu: add i.MX6SX and
 i.MX7S SoCs.
In-Reply-To: <c5109c4f-705b-8c28-6b79-a40458933423@mentor.com>
References: <20180726065331.6186-1-o.rempel@pengutronix.de>
 <20180726065331.6186-5-o.rempel@pengutronix.de>
 <CABb+yY32vBy5qVYsQ6u45=rV6gEggqKy3Jqn1B4oWHaGfTyQ8Q@mail.gmail.com>
 <1532601691.32306.28.camel@pengutronix.de>
 <CABb+yY1GEmw_8q2HaF8y5VfFJX_c_0_MbWtPUE_j_o-zS8iZ_g@mail.gmail.com>
 <f3f84864-b6f5-350c-77ff-266b034e676e@mentor.com>
 <CABb+yY1v8j0G12Kd8-DqsJ6VoGBLuit2Cu+SFKixJudRAzXgkQ@mail.gmail.com>
 <c5109c4f-705b-8c28-6b79-a40458933423@mentor.com>
Message-ID: <CABb+yY02KNB9ELKiWYdB0LyvTghhk+nk-dTUGfG8_+KUB_H=Mw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2018 at 5:25 PM, Vladimir Zapolskiy
<vladimir_zapolskiy@mentor.com> wrote:
> On 07/26/2018 02:52 PM, Jassi Brar wrote:
>> On Thu, Jul 26, 2018 at 5:14 PM, Vladimir Zapolskiy
>> <vladimir_zapolskiy@mentor.com> wrote:

>>>
>> Please note the submitted driver absolutely don't care which of the
>> five SoCs it is.
>
> True.
>

>> In other words, all these SoCs have the same controller.
>
> False :)
>
OK, so the controllers are not identical, but same enough to have a
common driver?
Is the driver not tested enough or are you planning to add more features?

>> So its about have just one compatible right now, and add more if some
>> new SoC comes with a variation of the controller.
>>
>
> True. The driver will be changed in this case, unfortunately the bindings
> are not so volatile.
>
The volatility of the bindings will be same when you add a new SoC
compatible ;)  And you must add to bindings+driver, or the same h/w
and same driver won't work for your new platform.
