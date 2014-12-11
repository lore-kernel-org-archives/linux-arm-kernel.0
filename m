From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Thu, 11 Dec 2014 21:31:23 +0530
Subject: [PATCH 5/9] gpio: Add Fujitsu MB86S7x GPIO driver
In-Reply-To: <CACRpkdY_DFF8BjwLs5m4fe+-eBjmxYW6z4aU+zxiG+EgZys0+w@mail.gmail.com>
References: <1416486442-25200-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1416487023-25426-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <CACRpkdY_DFF8BjwLs5m4fe+-eBjmxYW6z4aU+zxiG+EgZys0+w@mail.gmail.com>
Message-ID: <CAJe_Zhef7D5-P4+bfgkbdaDB8HXm-Yb5SyrYRhO+SX1bcoLYNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 December 2014 at 19:02, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Thu, Nov 20, 2014 at 1:37 PM, Vincent Yang
> <vincent.yang.fujitsu@gmail.com> wrote:
>
>> Driver for Fujitsu MB86S7x SoCs that have a memory mapped GPIO controller.
>>
>> Signed-off-by: Andy Green <andy.green@linaro.org>
>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
>> Signed-off-by: Tetsuya Nuriya <nuriya.tetsuya@jp.fujitsu.com>
>
> This is a very simple MMIO GPIO controller.
>
> Why can this *not* just select GPIO_GENERIC and
> use drivers/gpio/gpio-generic.c?
>
The math isn't the simple shift operation that the gpio-generic.c assumes.

-jassi
