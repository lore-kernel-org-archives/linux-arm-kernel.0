From: tony@atomide.com (Tony Lindgren)
Date: Wed, 2 Mar 2011 16:32:26 -0800
Subject: [PATCH] arm: omap: fix section mismatch warning
In-Reply-To: <1299105706-2970-1-git-send-email-tom.leiming@gmail.com>
References: <1299105706-2970-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <20110303003226.GE20560@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* tom.leiming at gmail.com <tom.leiming@gmail.com> [110302 06:41]:
> From: Ming Lei <tom.leiming@gmail.com>
> 
> WARNING: arch/arm/plat-omap/built-in.o(.data+0x6d4): Section mismatch in reference from the variable omap_driver to the function .init.text:omap_cpu_init()
> The variable omap_driver references
> the function __init omap_cpu_init()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console,

Thanks I'll queue this for the upcoming merge window.

Tony
