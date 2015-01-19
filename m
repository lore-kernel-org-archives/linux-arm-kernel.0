From: Pankaj.Chauhan@freescale.com (Pankaj Chauhan)
Date: Mon, 19 Jan 2015 12:27:04 +0000
Subject: [Query] ARM64 : arm_pm_restart intialization
Message-ID: <BLUPR03MB167FE14DFB49FB4251C503F904A0@BLUPR03MB167.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I have a small query regarding machine_restart() for ARM64.

For both ARM64 and ARM32 machine_restart() (arch/arm*/kernel/process.c)
calls arm_pm_restart, for doing machine specific restart. For ARM32 arm_pm_restart, 
gets initialized by 'machine_desc.restart' provided by each machine/platform
implementation.

For ARM64 how are different platforms supposed to initialize arm_pm_restart pointer? 
(As there is no struct machine_desc defined for ARM64). Is there a framework similar
to machine_desc for setting up the restart handlers?

Thanks,
pankaj
