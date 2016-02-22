From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Feb 2016 15:44:44 +0100
Subject: [PATCH 00/61] gpio: Add and use devm_gpiochip_add_data()
In-Reply-To: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
References: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <CACRpkdbt+RiWMA74e40MNZVnDM0t0futtFnbyu9sRhv7p93-Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 3:07 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:

> Add resource management APIs for gpiochip_add_data() and
> gpiochip_remove() and use these APIs from different HW drivers.
>
> This is based on discussion on patch to use the new APIs.
>         gpio: Add devm_ apis for gpio_chip_add and remove

Awesome!

Do you have a git I can just pull these off so I don't have to apply
then all one-by-one?

Yours,
Linus Walleij
