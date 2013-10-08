From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 8 Oct 2013 10:17:20 +0200
Subject: [PATCH 1/3] pinctrl: sirf: add lost uart0-no-stream-control
 pingroup for prima2
In-Reply-To: <1380464879-19897-1-git-send-email-Baohua.Song@csr.com>
References: <1380464879-19897-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <CACRpkdbTdaAb35PVZMju=0MjtopVe4VKKSWW-TmuvnxtqZZjxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 29, 2013 at 4:27 PM, Barry Song <21cnbao@gmail.com> wrote:

> From: Qipan Li <Qipan.Li@csr.com>
>
> the old codes defined uart0_nostreamctrl_pins, but missed pingroup
> and padmux definition for it. this patch fixes it.
>
> Signed-off-by: Qipan Li <Qipan.Li@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---
>  arch/arm/boot/dts/prima2.dtsi         | 6 ++++++
>  drivers/pinctrl/sirf/pinctrl-prima2.c | 3 +++

Usually I'd split off the DT changes separately and take these
through ARM SoC, but whatever, no big deal. Patch applied.

Yours,
Linus Walleij
