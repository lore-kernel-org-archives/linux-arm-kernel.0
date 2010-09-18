From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 18 Sep 2010 03:08:39 +0200
Subject: [PATCH] at91: fix arch_gettimeoffset fallout
In-Reply-To: <1284730276-21657-1-git-send-email-jacmet@sunsite.dk>
References: <1284730276-21657-1-git-send-email-jacmet@sunsite.dk>
Message-ID: <20100918010839.GC21110@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:31 Fri 17 Sep     , Peter Korsgaard wrote:
> 5cfc8ee0bb51 (ARM: convert arm to arch_gettimeoffset()) marked all of
> at91 AND at91x40 as needing ARCH_USES_GETTIMEOFFSET, and hence no high
> res timer support / accurate clock_gettime() - But only at91x40 needs it.
> 
> Signed-off-by: Peter Korsgaard <peter.korsgaard@barco.com>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
