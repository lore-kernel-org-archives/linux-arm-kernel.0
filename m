From: jrudholm@gmail.com (Johan Rudholm)
Date: Thu, 11 Oct 2012 08:50:34 +0200
Subject: [RESEND PATCH 2/2] mmc: mmci: Switching off HWFC for SDIO depends
 on MCLK
In-Reply-To: <CACRpkdbWVLJKroUgX_kSO4Mwgxfhe3gZO9701xmpDuQJKx7sOQ@mail.gmail.com>
References: <1349885000-22887-1-git-send-email-ulf.hansson@stericsson.com>
 <1349885000-22887-2-git-send-email-ulf.hansson@stericsson.com>
 <CACRpkdbWVLJKroUgX_kSO4Mwgxfhe3gZO9701xmpDuQJKx7sOQ@mail.gmail.com>
Message-ID: <CA+20K0As20SrYGMQy8zmuH3SR=fcwnyiEfAa1svYOp2xokmaQA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/10/10 Linus Walleij <linus.walleij@linaro.org>:
> On Wed, Oct 10, 2012 at 6:03 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
>
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> For writes, HWFC shall be switched off when transfer size <= 8
>> bytes and when MCLK rate is above 50 MHz. For 50MHz and below
>> it shall be switched off when transfer size < 8 bytes.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Johan Rudholm <johan.rudholm@stericsson.com>
