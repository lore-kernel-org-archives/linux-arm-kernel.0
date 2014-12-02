From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Dec 2014 15:50:12 +0100
Subject: [PATCH 1/2] pinctrl: at91: allow disabled gpio controllers
In-Reply-To: <547C7446.1090909@atmel.com>
References: <1417193367-12422-1-git-send-email-ludovic.desroches@atmel.com>
 <547C7446.1090909@atmel.com>
Message-ID: <CACRpkdZAmqXVOfm6dF=FX7EJUqmAySpP2Kop2kcTzO5zf4Xg9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 1, 2014 at 2:59 PM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> Le 28/11/2014 17:49, Ludovic Desroches a ?crit :
>> This patch allows to have gpio controller with status set to disabled.
>>
>> gpio_banks represents all the gpio banks available on the device whereas
>> nbanks represents the gpio banks used. Having a disabled gpio controller
>> involves that nbanks value is lower than gpio_banks and that some
>> pointers in the gpio_chips array are NULL. This patch deals with these
>> specific cases.
>>
>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>
> Yes:
>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> Linus, is it too late for 3.18?

I think it's too late for any kernel as I think it's the wrong fix ;)

Yours,
Linus Walleij
