From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Mon, 9 Mar 2015 22:22:17 +0530
Subject: [PATCH] pinctrl: exynos: Remove eint_gpio_init call-back for
 exynos7 alive pinctrl block
In-Reply-To: <CA+Ln22HGH3r6UEYtCPU7Y4a0-b4FKnx8d0VcA3a1-m1VD5Jm=w@mail.gmail.com>
References: <1425226876-5122-1-git-send-email-a.kesavan@samsung.com>
 <CA+Ln22HGH3r6UEYtCPU7Y4a0-b4FKnx8d0VcA3a1-m1VD5Jm=w@mail.gmail.com>
Message-ID: <CAM4voandpVQqVtHgZdTViEzNtBj=XWJ7A7yY5oGqgqg4btxzCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Mon, Mar 9, 2015 at 3:54 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Abhilash, Linus,
>
> 2015-03-02 1:21 GMT+09:00 Abhilash Kesavan <a.kesavan@samsung.com>:
>> The alive pin controller on exynos7 does not support external gpio
>> interrupts. Hence, remove the eint_gpio_init call-back for it. This
>> fixes the following error message seen during exynos7 boot-up:
>> "samsung-pinctrl 10580000.pinctrl: irq number not available"
>
> As long as "external gpio interrupts" refer to non-wake-up-capable
> GPIO interrupts I'm fine with this patch.

Yes, that was the intention. Thanks for the review.

Regards,
Abhilash
>
> Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
>
> Thanks Linus for pinging and sorry for delay.
>
> Best regards,
> Tomasz
