From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 13 Aug 2010 14:45:30 +0900
Subject: warning: (CPU_V7 && !ARCH_OMAP2 || CPU_MMP2 && ARCH_MMP)
Message-ID: <007f01cb3aaa$cc469460$64d3bd20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I found build warning in the latest Linus' tree like following.

warning: (CPU_V7 && !ARCH_OMAP2 || CPU_MMP2 && ARCH_MMP) selects CPU_32v6K
which has unmet direct dependencies (CPU_V6)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
