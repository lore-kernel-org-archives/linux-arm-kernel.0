From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 24 Jun 2011 22:15:27 +0530
Subject: [PATCH 1/4] davinci: psc.h: clean up indentation done using spaces
In-Reply-To: <1301072400-4036-1-git-send-email-nsekhar@ti.com>
References: <1301072400-4036-1-git-send-email-nsekhar@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D6C2F3E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, SubArch team,

This series of 4 patches added SATA support on DaVinci
DA850 platform. This was ready for last merge window,
but was not queued because of the negative diffstat
rule.

Is there a possibility of queuing this for the v3.1 merge?

Here is the archive link of this posting:

http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2011-March/022473.html

Here is the summary diffstat:

 arch/arm/mach-davinci/board-da850-evm.c    |    7 ++
 arch/arm/mach-davinci/clock.c              |    8 +-
 arch/arm/mach-davinci/clock.h              |    1 +
 arch/arm/mach-davinci/da850.c              |    9 ++
 arch/arm/mach-davinci/devices-da8xx.c      |  122 ++++++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |    2 +
 arch/arm/mach-davinci/include/mach/psc.h   |  151 ++++++++++++++--------------
 arch/arm/mach-davinci/psc.c                |    4 +-
 8 files changed, 225 insertions(+), 79 deletions(-)

Thanks,
Sekhar
