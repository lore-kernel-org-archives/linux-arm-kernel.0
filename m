From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Sep 2012 01:47:09 -0700
Subject: [PATCH 01/19] ARM: ux500: Add skeleton Device Tree for the HREF
 reference board
In-Reply-To: <1347016499-29354-2-git-send-email-lee.jones@linaro.org>
References: <1347016499-29354-1-git-send-email-lee.jones@linaro.org>
 <1347016499-29354-2-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdbWVjiqrehj_v7M=cgnytEio5whTXOcax5wo0YSRe=-yA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 7, 2012 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:

> First commit applying the new Device Tree for ST-Ericsson's u8500
> based hardware reference board.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

> +/dts-v1/;
> +/include/ "dbx5x0.dtsi"

This include is not even in linux-next, is this patch series dependent
on some other series I have not seen, or that I have forgot that
I saw (and even possibly ACKed...)

Apart from that it looks good.

Yours,
Linus Walleij
