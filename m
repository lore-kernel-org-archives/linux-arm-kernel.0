From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 9 Aug 2013 09:11:09 -0400
Subject: [PATCH 3/5] ARM: mach-mvebu: remove redundant DT parsing and
 validation
In-Reply-To: <1374579164-30255-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374579164-30255-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374579164-30255-4-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <20130809131109.GA25111@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 23, 2013 at 12:32:42PM +0100, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> 
> arm_dt_init_cpu_maps parses the device tree, validates and sets the
> cpu_possible_mask appropriately. It is unnecessary to do another DT
> parse to get the number of cpus, use num_possible_cpus instead.
> 
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> ---
>  arch/arm/mach-mvebu/platsmp.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)

Applied to mvebu/soc with Gregory's Ack

thx,

Jason.
