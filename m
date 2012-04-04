From: olof@lixom.net (Olof Johansson)
Date: Wed, 4 Apr 2012 12:17:54 -0700
Subject: [PATCH v2 13/13] ARM: at91: dt: remove unit-address part for
 memory nodes
In-Reply-To: <1db62b280314855c35cb7a3188fc9d9cb8501948.1333437885.git.nicolas.ferre@atmel.com>
References: <cover.1333437885.git.nicolas.ferre@atmel.com>
 <1db62b280314855c35cb7a3188fc9d9cb8501948.1333437885.git.nicolas.ferre@atmel.com>
Message-ID: <20120404191754.GE10603@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 03, 2012 at 09:32:57AM +0200, Nicolas Ferre wrote:
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Having a unit-address different from 0 causes bad memory node detection
> during early_init_dt_scan_memory.

Sounds like a bug in the generic code to me? But specifying a unit
address on a non-ambiguous device node isn't necessary anyway, so this
patch is still a reasonable thing to do.

> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: devicetree-discuss at lists.ozlabs.org

Acked-by: Olof Johansson <olof@lixom.net>



-Olof
