From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Oct 2017 23:52:38 +0200
Subject: [PATCH] mtd: nand: gpio: Convert to use GPIO descriptors
In-Reply-To: <87fuawf1h8.fsf@belgarion.home>
References: <20170924173912.9199-1-linus.walleij@linaro.org>
 <87fuawf1h8.fsf@belgarion.home>
Message-ID: <CACRpkdZEx8=887BiW786Cfh89yjLx1cVdJ=jdD+tVdqec-k3Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 6, 2017 at 10:46 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:
>
>>  #if defined(CONFIG_MTD_NAND_GPIO) || defined(CONFIG_MTD_NAND_GPIO_MODULE)
>> +
>> +static struct gpiod_lookup_table cmx255_nand_gpiod_table = {
>> +     .dev_id         = "cmx255-nand",
> Shouldn't the device name be "gpio-nand" instead ?
> "cmx255-nand" is AFAIR a partition name, not a device name.

My silly mistake. Sent a fixup patch.

Thanks for spotting this!

Yours,
Linus Walleij
