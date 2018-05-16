From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 May 2018 14:55:00 +0200
Subject: [PATCH] pinctrl: mvebu: use correct MPP sel value for dev pins
In-Reply-To: <20180507022555.31645-1-chris.packham@alliedtelesis.co.nz>
References: <20180507022555.31645-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <CACRpkdbAaMrHJ8TjJTtNyVtoOSRAEf2Z8gRthFH0ze4RyybBag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2018 at 4:25 AM, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:

> The "dev" function is selected with the value 0x4 not 0x01.
>
> Fixes: commit d7ae8f8dee7f ("pinctrl: mvebu: pinctrl driver for 98DX3236 SoC")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Patch applied.

Does it need to go into fixes? Stable?

Yours,
Linus Walleij
