From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Nov 2017 16:49:42 +0100
Subject: [PATCH] pinctrl: sunxi: Fix A64 UART mux value
In-Reply-To: <20171125121230.23555-1-andre.przywara@arm.com>
References: <20171125121230.23555-1-andre.przywara@arm.com>
Message-ID: <CACRpkdZHdPuWa5sR72cpb6cjRmrYRt6VzA3YQ2jbc-+1DbdAdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 25, 2017 at 1:12 PM, Andre Przywara <andre.przywara@arm.com> wrote:

> To use pin PF4 as the RX signal of UART0, we have to write 0b011 into
> the respective pin controller register.
> Fix the wrong value we had in our table so far.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Patch applied with Chen-Yu's ACK and fixes tag.

Yours,
Linus Walleij
