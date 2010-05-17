From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Mon, 17 May 2010 08:21:45 +0200
Subject: [PATCH] SPI: fix up some PL022 confusion
In-Reply-To: <AANLkTil25g0DEafaicc_fShwz9gpF8Dl9NgyG6E0wu-r@mail.gmail.com>
References: <1273051695-32251-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTil25g0DEafaicc_fShwz9gpF8Dl9NgyG6E0wu-r@mail.gmail.com>
Message-ID: <AANLkTinsCSb_k3y8iqk4nJ5793SNeg-uBA7Ac95nuNsu@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/5/11 Linus Walleij <linus.ml.walleij@gmail.com>:
> 2010/5/5 Linus Walleij <linus.walleij@stericsson.com>:
>
>> The PL022 SPI driver did not cleanly separate between the
>> original unmodified ARM version and the ST Microelectronics
>> versions. Split this more cleanly and fix some whitespace
>> moaning from checkpatch at the same time.
>
> Grant/David have you had time to look at these two PL022
> patches?

Still travelling? I'm just worrying that if I have to make any updates
for the merge tree I need some slack... sorry for hammering.

Yours,
Linus Walleij
