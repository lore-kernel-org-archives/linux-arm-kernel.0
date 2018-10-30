From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Oct 2018 14:19:39 +0100
Subject: [PATCH 6/6] gpio: gpio-zynq: simplify getting .driver_data
In-Reply-To: <20181021200002.1472-7-wsa+renesas@sang-engineering.com>
References: <20181021200002.1472-1-wsa+renesas@sang-engineering.com>
 <20181021200002.1472-7-wsa+renesas@sang-engineering.com>
Message-ID: <CACRpkdawU7QaQEmM0-o=FBB9=-EYBUs9Rt2=Y_ZTF5xiL69Rdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 21, 2018 at 10:00 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:

> We should get 'driver_data' from 'struct device' directly. Going via
> platform_device is an unneeded step back and forth.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Patch applied.

Yours,
Linus Walleij
