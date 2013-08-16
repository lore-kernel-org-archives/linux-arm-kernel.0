From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Aug 2013 11:15:13 +0200
Subject: [PATCH] clk: ux500: Remove BML8580 clock
In-Reply-To: <20130815184202.4443.33356@quantum>
References: <1376257756-23575-1-git-send-email-linus.walleij@linaro.org>
 <20130815184202.4443.33356@quantum>
Message-ID: <CACRpkdZOPZE1aDw0NZDVX5_fVStqPFKqvLP-6dtjNawSCLg2Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 8:42 PM, Mike Turquette <mturquette@linaro.org> wrote:
> Quoting Linus Walleij (2013-08-11 14:49:16)
>> From: Lee Jones <lee.jones@linaro.org>
>>
>> There is no mention of the PRCMU_BML8580CLK in any of the Design
>> Specifications for the chips supported in Mainline. In fact, where it
>> is incorrectly used in the u8540 clock definition driver it would
>> have the side effect of using the incorrect clock management address
>> ([PRCM_BML8580CLK_MGT] 0x108 instead of the correct value 0x04C).
>>
>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
> Pulled into clk-next.


Hm it turns out that I need this to be in the middle of Lee's patch
set for device tree clock that need to go through ARM SoC.

Can you (please) drop this patch and provide an ACK instead?

Yours,
Linus Walleij
