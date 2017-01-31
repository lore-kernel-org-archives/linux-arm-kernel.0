From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 31 Jan 2017 13:05:15 +0800
Subject: [PATCH v2 17/25] mfd: axp20x: add CHRG_CTRL1/2/3 to writeable
 regs for AXP20X/AXP22X
In-Reply-To: <20170127085458.18270-18-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-18-quentin.schulz@free-electrons.com>
Message-ID: <CAGb2v65RqphAkWVqwmZr8tKhXxSrkYQSiwg6tTa8uKomuV0hmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 4:54 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> The CHRG_CTRL1 and CHRG_CTRL2 registers are made for controlling
> different battery charging settings such as the constant current charge
> value.
>
> The AXP22X also have a third register CHRG_CTRL3 which has settings for
> battery charging too.
>
> This adds the CHRG_CTRL1, CHRG_CTRL2 and CHRG_CTRL3 registers to the
> list of writeable registers for AXP20X and AXP22X PMICs.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
