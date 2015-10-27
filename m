From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 27 Oct 2015 13:08:42 +0100
Subject: [PATCH] arm64/efi: register UEFI runtime mmio regions as iomem
 resources
In-Reply-To: <1445848860-9547-1-git-send-email-ard.biesheuvel@linaro.org>
References: <CAD0U-h+cr0xpAAcCD1P8k2hUcJJL2Ga+-Grrb8WaZrgm08G2nA@mail.gmail.com>
 <1445848860-9547-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <CACRpkdact=Jh5WpghnyPU1Oaiu8pgvb=kwva-nEkJUX9NKL6xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 26, 2015 at 9:41 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:

> In order to prevent kernel drivers from attaching to MMIO regions
> that are owned by the firmware, register them as iomem resources.
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Is this related to the flash memory discussion so that NOR flash
will be part of what is considered "I/O memory" and flash
protection achieved this way?

Yours,
Linus Walleij
