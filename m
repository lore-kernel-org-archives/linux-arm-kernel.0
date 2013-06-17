From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 18:14:20 +0200
Subject: [PATCH] pinctrl: update GPIO range doc
In-Reply-To: <1371446435.2776.122@driftwood>
References: <1371377909-5921-1-git-send-email-linus.walleij@stericsson.com>
 <1371446435.2776.122@driftwood>
Message-ID: <CACRpkdZdPR-hrV_dRpochwZsM_E1SMZoSXFM9-MN_3Ko6Aa2cw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 17, 2013 at 7:20 AM, Rob Landley <rob@landley.net> wrote:
> On 06/16/2013 05:18:29 AM, Linus Walleij wrote:
>>
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This updates the GPIO range documentation with the API changes
>> for sparse/random/arbitrary pin-to-GPIO mappings.
>
> Acked-by: Rob Landley <rob@landley.net>
>
> Why isn't this part of the pinctrl series you posted right afterwards? (It
> should go in through that maintainer...)

Well I'm the pinctrl maintainer so I keep it all in my head :-D

>> +in gpio number, and use the ranges internals to retrive a pin number.
>> After
>
> Range's perhaps?

Thanks, fixed it up.

Yours,
Linus Walleij
