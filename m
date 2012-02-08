From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Wed, 08 Feb 2012 16:37:21 +0100
Subject: [PATCH] ARM: OMAP: update omap1 and omap2plus defconfigs
In-Reply-To: <1328696173-17226-1-git-send-email-grinberg@compulab.co.il>
References: <20120208053556.GB1426@atomide.com>
 <1328696173-17226-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <2185461.e7xKmI3MHi@vclass>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 of February 2012 12:16:13 Igor Grinberg wrote:
> ...
> After updating omap1_defconfig,
> there are several section mismatch warnings seen.
> Hopefully, I will have time to fix those tomorrow
> (unless someone will be kind enough to fix them before me).

Sound like introduced with my recent ams-delta patches, sorry.
I'll have a look at them.

Thanks,
Janusz

> The mismatches are:
> 
> WARNING: vmlinux.o(.data+0xb7e4): Section mismatch in reference from
> the variable latch1_gpio_device to the (unknown reference)
> .init.rodata:(unknown) The variable latch1_gpio_device references
> the (unknown reference) __initconst (unknown)
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> WARNING: vmlinux.o(.data+0xb8f4): Section mismatch in reference from
> the variable latch1_gpio_device to the (unknown reference)
> .init.rodata:(unknown) The variable latch1_gpio_device references
> the (unknown reference) __initconst (unknown)
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> WARNING: vmlinux.o(.data+0xb974): Section mismatch in reference from
> the variable latch2_gpio_device to the (unknown reference)
> .init.rodata:(unknown) The variable latch2_gpio_device references
> the (unknown reference) __initconst (unknown)
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> WARNING: vmlinux.o(.data+0xba84): Section mismatch in reference from
> the variable latch2_gpio_device to the (unknown reference)
> .init.rodata:(unknown) The variable latch2_gpio_device references
> the (unknown reference) __initconst (unknown)
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
> 
> WARNING: vmlinux.o(.data+0xbb04): Section mismatch in reference from
> the variable ams_delta_kp_device to the (unknown reference)
> .init.data:(unknown) The variable ams_delta_kp_device references
> the (unknown reference) __initdata (unknown)
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console
