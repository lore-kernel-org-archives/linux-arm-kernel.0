From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Mon, 7 Jul 2014 19:03:20 +0200
Subject: [PATCH 0/5] Add a driver for the atmel ram controller
In-Reply-To: <1404746355-19988-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1404746355-19988-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <20140707190320.500e67c2@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alexandre,

On Mon,  7 Jul 2014 17:19:10 +0200
Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> The atmel ram controller needs one or more clocks to work. For now the
> CLK_IGNORE_UNUSED flag is used on those clocks. This patch set introduce a
> driver that will take care of taking those clocks.
> 
> The final goal is also to move the ioremap done in mach-at91 to that driver with
> a proper power management driver.
> 
>Apart from the minor comments I made on patch 1, you have my

Acked-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

That's great to see the dirty CLK_IGNORE_UNSUSED hack removed in favor
of this SDRAM controller driver approach.

Thanks,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
