From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 14 May 2018 21:54:44 +0200
Subject: [PATCH 20/21] i2c: stu300: make use of i2c_8bit_addr_from_msg
In-Reply-To: <20180514145330.4857-21-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se>
 <20180514145330.4857-21-peda@axentia.se>
Message-ID: <CACRpkdbE+wjocxyg0yx7im=220F7Cb2RhRYsXKEFhUnaaDStCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 4:53 PM, Peter Rosin <peda@axentia.se> wrote:

> Because it looks neater.
>
> Also restructure debug output for resends, since that code as a
> result is only handling debug output.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Looks good to me!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
