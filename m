From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 17 Jun 2015 10:20:32 +0200
Subject: [PATCH 1/2] pinctrl: rockchip: generalize perpin driver-strength
 setting
In-Reply-To: <2322857.kblfsanYOB@diego>
References: <2322857.kblfsanYOB@diego>
Message-ID: <CACRpkda7U++34xSi-ePb4g7tZLde80YSaooY6WHcM=n097ZiGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 12, 2015 at 11:50 PM, Heiko St?bner <heiko@sntech.de> wrote:

> The upcoming support for the RK3368 ARM64 SoC also supports perpin
> drive strength settings (at different register positions), so generalize
> the register and offset calculation to easily support this one too.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

Patch applied.

Yours,
Linus Walleij
