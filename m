From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Jun 2017 17:07:14 +0200
Subject: [PATCH] clocksource: timer-u300: Unmap region and unprepare clk
 obtained by of_iomap/clk_prepare_enable.
In-Reply-To: <4f413218d177cde9760f222329fde91b56797843.1498635400.git.arvind.yadav.cs@gmail.com>
References: <4f413218d177cde9760f222329fde91b56797843.1498635400.git.arvind.yadav.cs@gmail.com>
Message-ID: <CACRpkdZ1vAcyrmi-mZb+oHvS3L=efjxsbaRfN472brcaQQPVEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 28, 2017 at 9:38 AM, Arvind Yadav <arvind.yadav.cs@gmail.com> wrote:

> In case of error at init time, rollback iomapping and unprepare clk.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
