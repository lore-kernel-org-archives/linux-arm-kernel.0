From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Tue, 5 Oct 2010 21:55:51 +0200
Subject: [PATCHv3] ARM: imx: Add iram allocator functions
In-Reply-To: <1286307715-12276-1-git-send-email-Dinh.Nguyen@freescale.com>
References: <1286307715-12276-1-git-send-email-Dinh.Nguyen@freescale.com>
Message-ID: <AANLkTim+WNx1B860AgHeP_X2u7HRC3=40j3FKgAg_BXf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/10/5  <Dinh.Nguyen@freescale.com>:

> Add iram allocation functions using GENERIC_ALLOCATOR. The
> allocation size is 4KB multiples to guarantee alignment. The
> idea for these functions is for i.MX platforms to use them
> to dynamically allocate IRAM usage.

Neither here...

> +config IRAM_ALLOC
> + ? ? ? bool "Enable IRAM allocator"
> + ? ? ? select GENERIC_ALLOCATOR
> + ? ? ? help
> + ? ? ? ? Select this to have access to generic IRAM allocation functions that
> + ? ? ? ? use the GENERIC_ALLOCATOR. ?The allocation size is 4KB multiples to
> + ? ? ? ? guarantee alignment. The idea for these functions is for i.MX platforms
> + ? ? ? ? to use them to dynamically allocate IRAM usage.

Nor here is is explained what an IRAM is.

What is it? Is this yet another fancy name for on-chip-memory?

And why I? = Initial? Interrupt? ...?

Yours,
Linus Walleij
