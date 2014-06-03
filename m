From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 3 Jun 2014 09:53:17 +0200
Subject: [PATCH v2 4/7] ARM: shmobile: r8a7791: Add SYS-DMAC channel
 definitions for bindings
In-Reply-To: <538C818B.5060703@codethink.co.uk>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
 <1401716531-29794-5-git-send-email-geert+renesas@glider.be>
 <538C818B.5060703@codethink.co.uk>
Message-ID: <CAMuHMdWkPy8eydh4BntXdtf5ZJKP4yG26QovLUjvGUYYv3dStw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ben,

On Mon, Jun 2, 2014 at 3:52 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>> +// FIXME
>> +#define CHCR_RX_8BIT SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_8BIT)
>> +#define CHCR_TX_8BIT SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_8BIT)
>> +#define CHCR_RX_16BIT        SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_16BIT)
>> +#define CHCR_TX_16BIT        SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_16BIT)
>> +#define CHCR_RX_32BIT        SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_32BIT)
>> +#define CHCR_TX_32BIT        SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_32BIT)
>> +#define CHCR_RX_256BIT       SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_256BIT)
>> +#define CHCR_TX_256BIT       SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_256BIT)
>
> I am pretty sure for round-2 we can remove these in favour of a
> table in the driver. The only device that has a non-standard setting
> is the SDHI and that will support 32bit and 256bit transfers.

Thanks, I'm eagerly awaiting your next version...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
