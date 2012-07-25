From: zonque@gmail.com (Daniel Mack)
Date: Wed, 25 Jul 2012 20:11:45 +0200
Subject: [PATCH 1/2] GPIO: gpio-pxa: simplify pxa_gpio_to_irq() and
 pxa_irq_to_chip()
In-Reply-To: <201207251617.21735.arnd@arndb.de>
References: <1343230539-7196-1-git-send-email-zonque@gmail.com>
 <201207251617.21735.arnd@arndb.de>
Message-ID: <501036E1.5010309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.07.2012 18:17, Arnd Bergmann wrote:
> On Wednesday 25 July 2012, Daniel Mack wrote:
>> Simplify the code in gpio-pxa.c and make them based on irq_base.
>> When not probed from devicetree, initialize irq_base from
>> PXA_GPIO_TO_IRQ() or MMP_GPIO_TO_IRQ(), respectively, so the non-DT case
>> still works.
>>
>> Only tested on PXA3xx.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
> 
> Both look good to me,
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 

Thanks. I somehow lost track about the upstream pathes recently. Who
would queue them up now?


Daniel
