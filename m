From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Mar 2017 11:16:49 +0200
Subject: [PATCH v4 1/4] pinctrl: rockchip: remove unnecessary locking
In-Reply-To: <20170323105931.10455-2-john@metanate.com>
References: <20170323105931.10455-1-john@metanate.com>
 <20170323105931.10455-2-john@metanate.com>
Message-ID: <CACRpkdZHKWSzFXLqEmBkyANvExxperRT3kd5E5nKGbG10x8+dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 23, 2017 at 11:59 AM, John Keeping <john@metanate.com> wrote:

> regmap_update_bits does its own locking and everything else accessed
> here is a local variable so there is no need to lock around it.
>
> Signed-off-by: John Keeping <john@metanate.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> ---
> v3: unchanged
> v2.1:
> - Remove RK2928 locking in rockchip_set_pull()
> v2:
> - Also remove locking in rockchip_set_schmitt()

Patch applied.

Yours,
Linus Walleij
