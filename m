From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 16 Nov 2018 10:10:00 +0100
Subject: [PATCH 4/9] PCI: consolidate PCI config entry in drivers/pci
In-Reply-To: <20181115190538.17016-5-hch@lst.de>
References: <20181115190538.17016-1-hch@lst.de>
 <20181115190538.17016-5-hch@lst.de>
Message-ID: <CAMuHMdUSr6uxXUv8HtWZihFVj9zR8SJoFByLJ=J+_Lj-Mmgagg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 8:06 PM Christoph Hellwig <hch@lst.de> wrote:
> There is no good reason to duplicate the PCI menu in every architecture.
> Instead provide a selectable HAVE_PCI symbol that indicates availability
> of PCI support, and a FORCE_PCI symbol to for PCI on and the handle the
> rest in drivers/pci.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
