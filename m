From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Oct 2018 14:24:46 +0100
Subject: [PATCH 5/5] pinctrl: pinctrl-at91-pio4: simplify getting
 .driver_data
In-Reply-To: <20181021200032.1833-6-wsa+renesas@sang-engineering.com>
References: <20181021200032.1833-1-wsa+renesas@sang-engineering.com>
 <20181021200032.1833-6-wsa+renesas@sang-engineering.com>
Message-ID: <CACRpkdYVa=0JOkRT=sm-eB+NSMGjHyWAzzZrc6UY8jdYRpuOtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2018 at 10:00 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Patch applied with the acks.

Yours,
Linus Walleij
