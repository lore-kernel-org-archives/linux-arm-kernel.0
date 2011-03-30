From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 30 Mar 2011 14:04:53 +0200
Subject: [PATCH] arm: at91: fix compiler warning for eb01 board build
In-Reply-To: <1301460212-6940-1-git-send-email-gerg@uclinux.org>
References: <1301460212-6940-1-git-send-email-gerg@uclinux.org>
Message-ID: <20110330120453.GB7420@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:43 Wed 30 Mar     , Greg Ungerer wrote:
> Fix compiler warning when building for AT91EB01 board:
> 
> arch/arm/mach-at91/board-eb01.c:41: warning: initialisation from incompatible pointer type
> 
> Signed-off-by: Greg Ungerer <gerg@uclinux.org>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
