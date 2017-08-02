From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Aug 2017 11:25:21 +0200
Subject: [PATCH v2 3/3] gpio: davinci: Convert prinkt to dev_err
In-Reply-To: <1500543738-9696-4-git-send-email-j-keerthy@ti.com>
References: <1500543738-9696-1-git-send-email-j-keerthy@ti.com>
 <1500543738-9696-4-git-send-email-j-keerthy@ti.com>
Message-ID: <CACRpkdYCGm7TcGPFFauec2fiWop++5N8SqOnsYZ9=me5qs5L_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 11:42 AM, Keerthy <j-keerthy@ti.com> wrote:

> In case of devm_clk_get failure use dev_err instead of printk
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Patch applied.

Yours,
Linus Walleij
