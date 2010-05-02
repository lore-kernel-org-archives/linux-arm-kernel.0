From: avictor.za@gmail.com (avictor.za at gmail.com)
Date: Sun, 2 May 2010 22:10:29 +0200
Subject: [at91] Save power by disabling the processor clock when CPU is
	idle
In-Reply-To: <1271156732l.25331l.7l@i-dmzi_al.realan.de>
References: <1271156732l.25331l.7l@i-dmzi_al.realan.de>
Message-ID: <j2ncd73a99e1005021310w1c6471et6c58ffce68a4137b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Disable the processor clock when the CPU is idle.
>
> This saves much more power than merely entering 'Wait for Interrupt' mode.
> Since JTAG-debugging doesn't work when the processor clock is switched off,
> make it conditional on CONFIG_DEBUG_KERNEL.
>
> Signed-off-by: Anders Larsen <al@alarsen.net>
> Cc: Andrew Victor <avictor.za@gmail.com>

Acked-by: Andrew Victor <linux@maxim.org.za>

Russell:  It is patch 6053/1 in the patch-system.
