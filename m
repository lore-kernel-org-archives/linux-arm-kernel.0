From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 May 2013 10:54:09 +0200
Subject: [PATCH 3/9] clk: ux500: Provide device enumeration number suffix
 for SMSC911x
In-Reply-To: <20130514155835.10068.93655@quantum>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
 <1368019749-19455-4-git-send-email-lee.jones@linaro.org>
 <20130514155835.10068.93655@quantum>
Message-ID: <CACRpkdZjvQF9e_isiuUgmcH0RgoGGF=dmg_E7oQjs4oY9f+dFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 14, 2013 at 5:58 PM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Lee Jones (2013-05-08 06:29:03)
>> First Ethernet device has a ".0" appended onto the device name. It
>> appears that we need this in order to obtain the correct clock.
>>
>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> Cc: Mike Turquette <mturquette@linaro.org>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> Looks good to me.  Can I take this into clk-next or are you looking for
> an Ack?

You can probably take it through the clk tree, but this series
deals with regression fixes so it should go into the -rc series
I think.

Yours,
Linus Walleij
