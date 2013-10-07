From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 7 Oct 2013 17:32:20 +0100
Subject: [PATCH v2 19/29] of: create default early_init_dt_add_memory_arch
In-Reply-To: <1381163377-21044-20-git-send-email-robherring2@gmail.com>
References: <1381163377-21044-1-git-send-email-robherring2@gmail.com>
 <1381163377-21044-20-git-send-email-robherring2@gmail.com>
Message-ID: <20131007163220.GJ32012@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 05:29:27PM +0100, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Create a weak version of early_init_dt_add_memory_arch which uses
> memblock. This will unify all architectures except ones with custom
> memory bank structs.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Michal Simek <monstr@monstr.eu>
> Cc: Jonas Bonn <jonas@southpole.se>
> Acked-by: Grant Likely <grant.likely@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: microblaze-uclinux at itee.uq.edu.au
> Cc: linux at lists.openrisc.net
> Cc: devicetree at vger.kernel.org

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
