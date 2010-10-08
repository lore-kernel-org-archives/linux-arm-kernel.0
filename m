From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 8 Oct 2010 14:29:18 +0200
Subject: AT91: Fix power-saving in idle-mode on 926T processors
In-Reply-To: <20101007194415.GA24709@alarsen.net>
References: <20101007194415.GA24709@alarsen.net>
Message-ID: <20101008122918.GA30252@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21:44 Thu 07 Oct     , Anders Larsen wrote:
> According to Atmel, their 926T processors (AT91 post RM9200) requires
> 'Wait for Interrupt' mode be entered right after disabling the processor clock
> in order to minimise current consumption when idle, so do both provided we're
> not running on a 920T (an RM9200).
> 
> Furthermore, get rid of the #ifndef CONFIG_DEBUG_KERNEL, since arch_idle()
> can be turned off completely with the kernel parameter 'nohlt'.
> 
> Signed-off-by: Anders Larsen <al@alarsen.net>
> Cc: Andrew Victor <avictor.za@gmail.com>
please rebase against this branch

git://github.com/at91linux/linux-2.6-at91.git branch for-rmk

Best Regards,
J.
