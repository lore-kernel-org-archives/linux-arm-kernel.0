From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 23 Jan 2013 10:46:40 +0100
Subject: [PATCH 1/1] ARM: ux500: Enable Snowball's GPIO controlled
 Ethernet regulator in DT
In-Reply-To: <1358775323-8155-1-git-send-email-lee.jones@linaro.org>
References: <1358775323-8155-1-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbWVVW98upGcqCsbNXPU9Q2m5VFe71GwngBni4ih+m8_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 21, 2013 at 2:35 PM, Lee Jones <lee.jones@linaro.org> wrote:

> The Snowball Board's Ethernet chip is configured in a slightly
> non-standard way. Its SoC has an address space usually reserved
> for a NOR-flash device. However, on the Snowball, that external
> bus is populated by the SMSC9115 Ethernet chip. So, to power on
> the Ethernet chip, we have to enable the GPIO controlled
> regulator which usually controls the NOR-flash. In this patch
> we inform the Snowball's Device Tree which GPIO is used to
> operate it.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess you will funnel this to ARM SoC with other DT patches?

Yours,
Linus Walleij
