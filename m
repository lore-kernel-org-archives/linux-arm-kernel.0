From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 14 Oct 2013 16:23:58 +0200
Subject: [PATCH v3 04/14] ARM: mvebu: Remove the unused argument of
 set_cpu_coherent()
In-Reply-To: <1381759106-15004-5-git-send-email-gregory.clement@free-electrons.com>
References: <1381759106-15004-1-git-send-email-gregory.clement@free-electrons.com>
 <1381759106-15004-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20131014162358.01e338bb@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Gregory CLEMENT,

On Mon, 14 Oct 2013 15:58:16 +0200, Gregory CLEMENT wrote:
> set_cpu_coherent() took the SMP group ID as parameter. But this
> parameter was never used, and the CPU always use the SMP group 0. So

use -> uses

But probably better: "But this parameter was never used, and all CPUs
are always joining the SMP group 0".

Other than that:

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
