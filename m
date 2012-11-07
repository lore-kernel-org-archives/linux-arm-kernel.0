From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 7 Nov 2012 16:27:29 +0100
Subject: [PATCH 1/5] ARM: AT91SAM9G45: fix crypto peripherals irq issue
 due to sparse irq support.
In-Reply-To: <1352219463-30360-1-git-send-email-nicolas@eukrea.com>
References: <1352219463-30360-1-git-send-email-nicolas@eukrea.com>
Message-ID: <20121107152729.GE4576@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:31 Tue 06 Nov     , Nicolas Royer wrote:
> Spare irq support introduced by commit "8fe82a5 ARM: at91: sparse irq support"
> involves to add the NR_IRQS_LEGACY offset to irq number.
> 
> Signed-off-by: Nicolas Royer <nicolas@eukrea.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Acked-by: Eric B?nard <eric@eukrea.com>
> Tested-by: Eric B?nard <eric@eukrea.com>
> Cc: stable at vger.kernel.org # 3.6

ok will see if we can have it for 3.7

Best Regards,
J.
