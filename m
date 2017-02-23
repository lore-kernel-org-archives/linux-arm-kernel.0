From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 23 Feb 2017 11:53:17 +0100
Subject: [PATCH v3 01/18] drivers/fsi: Add empty fsi bus definitions
In-Reply-To: <20170201165358.45415-2-cbostic@linux.vnet.ibm.com>
References: <20170201165358.45415-1-cbostic@linux.vnet.ibm.com>
 <20170201165358.45415-2-cbostic@linux.vnet.ibm.com>
Message-ID: <CAMuHMdUhiXCnjT60Lsqq4eGGnVv9eavtkVL1Mdk_6naBHBDVrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris, Jeremy,

On Wed, Feb 1, 2017 at 5:53 PM, Christopher Bostic
<cbostic@linux.vnet.ibm.com> wrote:
> From: Jeremy Kerr <jk@ozlabs.org>
>
> This change adds the initial (empty) fsi bus definition, and introduces
> drivers/fsi/.
>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
> Signed-off-by: Chris Bostic <cbostic@us.ibm.com>

> --- /dev/null
> +++ b/drivers/fsi/Kconfig
> @@ -0,0 +1,12 @@
> +#
> +# FSI subsystem
> +#
> +
> +menu "FSI support"
> +
> +config FSI
> +       tristate "FSI support"

I guess this should depend on some POWER symbol || COMPILE_TEST?

> +       ---help---
> +         FSI - the FRU Support Interface - is a simple bus for low-level
> +         access to POWER-based hardware.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
