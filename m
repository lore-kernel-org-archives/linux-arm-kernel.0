From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 May 2013 20:15:28 +0200
Subject: [PATCH 05/11] ARM: davinci: creation of gpio platform device for
 dm platforms
In-Reply-To: <1369206634-6778-6-git-send-email-avinashphilip@ti.com>
References: <1369206634-6778-1-git-send-email-avinashphilip@ti.com>
 <1369206634-6778-6-git-send-email-avinashphilip@ti.com>
Message-ID: <CACRpkdavLhkJ2Osa-SHp_ekxGu-gtJ7AKTXuOHHZr1Z4BUEawQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 9:10 AM, Philip Avinash <avinashphilip@ti.com> wrote:

> gpio controller resource information being associated with
> davinci_soc_info structure and not created any device. Hence davinci
> gpio didn't fall under proper device model. This patch creates gpio
> davinci as a platform device for dm platforms.
> Also add daivinci_register_gpio API to create platform device for dm*
> platforms.
>
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
