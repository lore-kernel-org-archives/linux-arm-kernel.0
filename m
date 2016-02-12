From: alexandre.torgue@gmail.com (Alexandre Torgue)
Date: Fri, 12 Feb 2016 16:01:10 +0100
Subject: [PATCH 0/4] Add Ethernet support on STM32F429
In-Reply-To: <20160209.045214.805916119264070573.davem@davemloft.net>
References: <1454511275-9791-1-git-send-email-alexandre.torgue@gmail.com>
 <20160209.045214.805916119264070573.davem@davemloft.net>
Message-ID: <CAJgp7zxMoHD+zqHgsOvB=+wx=TtqqL0HH_3o=J=712QsvJvZwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

I will fix it in next patch version.
I just find a corruption issue in stmmac driver, I will also fix it in
next version.

Best regards

Alex

2016-02-09 10:52 GMT+01:00 David Miller <davem@davemloft.net>:
> From: Alexandre TORGUE <alexandre.torgue@gmail.com>
> Date: Wed,  3 Feb 2016 15:54:31 +0100
>
>> STM32F429 Chip embeds a Synopsys 3.50a MAC IP.
>> This series:
>>       -enhance current stmmac driver to control it (code already available) and
>>        adds basic glue for STM32F429 chip.
>>       -Enable basic Net config in kernel.
>>
>> Note that DT patches are not present because STM32 pinctrl code is not
>> yet avalaible.
>
> Looks like this needs to be respun to deal with the warnings the kbuild
> robot reported.
>
> Thanks.
