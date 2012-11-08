From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 8 Nov 2012 13:52:16 +0100
Subject: [PATCH 1/5] gpiolib: fix up function prototypes etc
In-Reply-To: <CAKohpon2OBMgNjc5RRGibEUqN_yPGPdXX5RBFP-bQLmyeF4zuw@mail.gmail.com>
References: <1352214994-30232-1-git-send-email-linus.walleij@stericsson.com>
 <CAKohpon2OBMgNjc5RRGibEUqN_yPGPdXX5RBFP-bQLmyeF4zuw@mail.gmail.com>
Message-ID: <CACRpkda0mZ8=ZhR7XkM8b09tWQeK8N3gKTv_FTNTnp_=ennqeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 7, 2012 at 6:09 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 6 November 2012 20:46, Linus Walleij <linus.walleij@stericsson.com>

>> -void gpiochip_add_pin_range(struct gpio_chip *chip, const char
>> *pinctl_name,
>> -               unsigned int pin_base, unsigned int npins);
>> -void gpiochip_remove_pin_ranges(struct gpio_chip *chip);
>> -#endif
>> +#ifdef CONFIG_PINCTRL
>
> Shouldn't this be ifndef??

Probably, fixed up in later patches...

Yours,
Linus Walleij
