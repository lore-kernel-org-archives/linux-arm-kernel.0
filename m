From: jrudholm@gmail.com (Johan Rudholm)
Date: Thu, 11 Oct 2012 08:51:42 +0200
Subject: [RESEND PATCH 1/2] mmc: mmci: Fix incorrect handling of HW flow
 control for SDIO
In-Reply-To: <CACRpkdYarGEzYoJwHggQh2O=hw_wyhP9KQ2GRruWh64SwnH=VA@mail.gmail.com>
References: <1349885000-22887-1-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdYarGEzYoJwHggQh2O=hw_wyhP9KQ2GRruWh64SwnH=VA@mail.gmail.com>
Message-ID: <CA+20K0ACHvVMHnTJ9Uw432u5n5i2z=oM9QGEbHeLXx8QuOkvSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/10 Linus Walleij <linus.walleij@linaro.org>:
> On Wed, Oct 10, 2012 at 6:03 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> For data writes <= 8 bytes, HW flow control was disabled but
>> never re-enabled when the transfer was completed. This meant
>> that a following read request would give buffer overrun errors.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Looks correct to me:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Johan Rudholm <johan.rudholm@stericsson.com>
