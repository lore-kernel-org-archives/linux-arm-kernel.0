From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sun, 5 Aug 2012 10:58:57 +0800
Subject: [PATCH v3 5/9] GPIO: gpio-pxa: fix devicetree functions
In-Reply-To: <CACRpkdb+N+sP1yA+JRe9Gqh9bHt-Nmx_+fxZKwmddrCcd-1a4g@mail.gmail.com>
References: <1343470061-16879-1-git-send-email-zonque@gmail.com>
 <1343470061-16879-6-git-send-email-zonque@gmail.com>
 <CACRpkdb+N+sP1yA+JRe9Gqh9bHt-Nmx_+fxZKwmddrCcd-1a4g@mail.gmail.com>
Message-ID: <CAN1soZywD8QcOn3W4z4n-E87_ZJhtufYDR6390T-zuqzv9T92Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 5, 2012 at 7:40 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sat, Jul 28, 2012 at 12:07 PM, Daniel Mack <zonque@gmail.com> wrote:
>
>> Provide an of_xlate function for the PXA GPIO chips and make it work for
>> devicetree environments.
>>
>> Successfully tested on a PXA3xx board.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>
> Are you planning to funnel these through say arm-soc?
>
> Yours,
> Linus Walleij

Yes, Daniel plans to go through arm-soc. And I merged it into pxa git tree.

Regards
Haojian
