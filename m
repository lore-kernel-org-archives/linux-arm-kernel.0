From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 7 Aug 2017 10:50:48 +0200
Subject: [PATCH v2 10/23] pinctrl: rockchip: add schmitt input mode
 support for rv1108
In-Reply-To: <1501663217-12255-1-git-send-email-andy.yan@rock-chips.com>
References: <1501662303-11687-1-git-send-email-andy.yan@rock-chips.com>
 <1501663217-12255-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <CACRpkdZZh_vix_+atNk-r8ZCGV3HR-SJ6fzbFwFS6GEodqAbCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 2, 2017 at 10:40 AM, Andy Yan <andy.yan@rock-chips.com> wrote:

> Some pins like i2c SCL/SDA need the schmitt input function
> to avoid crosstalk problems.
>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> ---
>
> Changes in v2: None

Already applied v1 with Heiko's ACK so should be fine then.

Yours,
Linus Walleij
