From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 16 Aug 2013 17:42:25 +0200
Subject: [PATCH] gpio: (gpio-pca953x) move header to linux/platform_data/
In-Reply-To: <82440653.410050.1376665340121.JavaMail.root@mail>
References: <CACRpkdZdeVNtJSmc6Lr6j=oO9FLsAvjyrwhYS0j4OoAEhxCN9g@mail.gmail.com>
 <82440653.410050.1376665340121.JavaMail.root@mail>
Message-ID: <CACRpkdYX_u3yn0AhyMpCSYoQQJdaWJeK_GztxNM_LUL15WpAhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 16, 2013 at 5:02 PM, Vivien Didelot
<vivien.didelot@savoirfairelinux.com> wrote:

>> Why does the GPIO driver need platform data from the
>> I2C driver???
>>
>> Can't this just be made to go away?
>
> I didn't dig that much in the driver, but I cannot imagine
> another way to pass, for instance, the setup callback.

Hm so this is some combined platform data for I2C *and* GPIO?

Hmm ugly, but OK then.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
