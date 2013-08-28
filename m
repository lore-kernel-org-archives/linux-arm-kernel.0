From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Aug 2013 14:45:04 +0200
Subject: [patch] pinctrl: s3c24xx: off by one in s3c24xx_eint_init()
In-Reply-To: <20130826233217.GA17061@elgon.mountain>
References: <20130826233217.GA17061@elgon.mountain>
Message-ID: <CACRpkdYtZndvqZgsuqLAieut3aMfF1hfwiWaWWjZccctfj66uA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 27, 2013 at 3:11 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:

> If "irq == NUM_EINT" then it writes one space beyond the end of the
> eint_data->domains[] array.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Patch applied with Heiko's ACK.

Yours,
Linus Walleij
