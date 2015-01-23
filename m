From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 23 Jan 2015 10:33:23 +0100
Subject: [PATCH v3 2/3] ARM: at91/dt: sama5d4: add pioD controller
In-Reply-To: <CACRpkdb3DoqsrqjaRptn=yUTRxy6fYLiPDWhViEe3Xf6jkT8Mg@mail.gmail.com>
References: <1421422267-2934-1-git-send-email-ludovic.desroches@atmel.com>	<1421422267-2934-3-git-send-email-ludovic.desroches@atmel.com>	<54BCE07C.8060601@atmel.com>
 <CACRpkdb3DoqsrqjaRptn=yUTRxy6fYLiPDWhViEe3Xf6jkT8Mg@mail.gmail.com>
Message-ID: <54C21563.2020801@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 21/01/2015 10:49, Linus Walleij a ?crit :
> On Mon, Jan 19, 2015 at 11:46 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
>> Le 16/01/2015 16:31, Ludovic Desroches a ?crit :
>>> PioD controller was not described in the device tree since we don't use
>>> it. As pinctrl-at91 allows disabled gpio controllers in the device
>>> tree, we can add it to complete the device description.
>>>
>>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
>>
>> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>>
>> Linus,
>>
>> As there is no dependency with the other patches in the series, I can
>> take this patch or you can keep it together with the other ones. Just
>> tell me once we agree all on a solution.
> 
> Please take this patch along with other AT91 stuff upstream
> through ARM SoC.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Ok, it is now stacked on top of our at91-3.20-dt branch and I'll send it
to arm-soc soon.

Thanks, bye.
-- 
Nicolas Ferre
