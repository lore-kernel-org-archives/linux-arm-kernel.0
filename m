From: leochen@broadcom.com (Leo (Hao) Chen)
Date: Fri, 23 Oct 2009 11:59:00 -0700
Subject: Question: support multiple boards of bcmring SoC?
Message-ID: <20091023185900.GI28382@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

We have multiple boards using the bcmring SoC, like evm board, sp board,
and we'd like to submit the support code to the community as well.
For the code we submitted to arch/arm/mach-bcmring, it supports only one
board for now.

My question is: what's the standard/best way to support multiple boards for
one SoC support?

Based on my understanding, we'd create the arch/arm/plat-bcmring
directory to store common code, and use arch/arm/mach-bcmring_evm, arch/arch/mach-bcmring_sp ..
to store board specific code.  Is my understanding correct? If not,
what's the best practice?

Thanks a lot for your advice.
-- 

Leo Hao Chen

------------------------
Life is short, run long.
