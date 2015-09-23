From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 23 Sep 2015 16:44:13 +0200
Subject: [PATCH v2 5/7] ARM: at91/defconfig: sama5: add PIO4 controller
 support
In-Reply-To: <CACRpkdY0iV+_xyfBSuUPuaRuZLfYYtpLHp5W7a-EYxxKrfEcVA@mail.gmail.com>
References: <1442417823-15850-1-git-send-email-ludovic.desroches@atmel.com>
 <1442417823-15850-6-git-send-email-ludovic.desroches@atmel.com>
 <CACRpkdY0iV+_xyfBSuUPuaRuZLfYYtpLHp5W7a-EYxxKrfEcVA@mail.gmail.com>
Message-ID: <5602BABD.7060308@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 21/09/2015 20:25, Linus Walleij a ?crit :
> On Wed, Sep 16, 2015 at 8:37 AM, Ludovic Desroches
> <ludovic.desroches@atmel.com> wrote:
> 
>> SAMA5D2 chip family has a new PIO controller.
>>
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Please merge this through Nicolas' AT91 tree.

Added in the at91-4.4-defconfig branch.

Thanks.

Paul,

This symbol will appear in Linus W.'s tree and is selected in mine. So
you may find that the symbol appear unused before the two trees are
merged in Linux-next or mainline.

Bye,
-- 
Nicolas Ferre
