From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Dec 2011 11:30:54 +0100
Subject: realview compulsory enables CONFIG_ARM_PATCH_PHYS_VIRT on me
In-Reply-To: <CACRpkdZ8jpz7WTP3gpfcTykQZaCjQLN9PZCAS+UJOWrzZo1bjQ@mail.gmail.com>
References: <CACRpkdZ8jpz7WTP3gpfcTykQZaCjQLN9PZCAS+UJOWrzZo1bjQ@mail.gmail.com>
Message-ID: <CACRpkdb8v8uXE-sLkP32YJqa7CYT2HX2Xq_F8mtXtZCYhSMH2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 5, 2011 at 10:22 PM, Linus Walleij <linus.walleij@linaro.org> wrote:

> In arch/arm/Kconfig ARM_PATCH_PHYS_VIRT is forcibly
> disabled like so:
>
> depends on !ARCH_REALVIEW || !SPARSEMEM

OK so I understand from the discussion that P2V should work
perfectly well with the RealView as long as you're not using
sparsemem. And now something has changed in v3.2-rc1
kernel so it gets default-selected as opposed to being
disabled in v3.1.

So my boot problem is likely due to something else...
I'll keep looking.

Yours,
Linus Walleij
