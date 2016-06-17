From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jun 2016 17:08:04 +0200
Subject: [PATCH 3/9] ARM: add missing <asm/prom.h>
In-Reply-To: <1466175913-19067-4-git-send-email-ben.dooks@codethink.co.uk>
References: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
 <1466175913-19067-4-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <6510999.J9HH6sHVW3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 17, 2016 4:05:07 PM CEST Ben Dooks wrote:
> Fix the following warnings by including declarations
> from <asm/prom.h>:
> 
> arch/arm/kernel/devtree.c:69:13: warning: symbol 'arm_dt_init_cpu_maps' was not declared. Should it be static?
> arch/arm/kernel/devtree.c:210:27: warning: symbol 'setup_machine_fdt' was not declared. Should it be static?
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
