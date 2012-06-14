From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 Jun 2012 19:13:02 +0200
Subject: [PATCH 2/3] ARM: ux500: Add i2c configurations to the Device Tree
 for DB8500 based devices
In-Reply-To: <4FD8BAE4.4050606@linaro.org>
References: <1339428307-3850-1-git-send-email-lee.jones@linaro.org>
 <1339428307-3850-10-git-send-email-lee.jones@linaro.org>
 <CACRpkdaMDbH4NkiHRLAfbJZ_j4QXbwg94bvaWsdYRPH+dSfc8Q@mail.gmail.com>
 <4FD8BAE4.4050606@linaro.org>
Message-ID: <CACRpkdaxoQGukJHy_JUKGu5CRFq5=9NcR-jqjPetMp85kAa-iQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2012 at 6:08 PM, Lee Jones <lee.jones@linaro.org> wrote:

> From: Lee Jones <lee.jones@linaro.org>
> Date: Wed, 13 Jun 2012 16:21:14 +0100
> Subject: [PATCH 2/3] ARM: ux500: Add i2c configurations to the Device Tree
> ?for DB8500 based devices
>
> For correct operation of the i2c-nomadik driver, it requires some
> information surrounding clock-frequencies, delay times and thresholds.
> Here we apply those configurations to be used when a platform is
> booted via the device Tree.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Splendid,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
