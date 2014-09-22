From: nm@ti.com (Nishanth Menon)
Date: Mon, 22 Sep 2014 08:17:08 -0500
Subject: [PATCH 08/10] ARM: OMAP5/DRA7: PM: cpuidle MPU CSWR support
In-Reply-To: <54201DE3.6030207@ti.com>
References: <1408716154-26101-1-git-send-email-nm@ti.com>
 <1408716154-26101-9-git-send-email-nm@ti.com>
 <5419D7BD.30003@linaro.org>
 <448912EABC71F84BBCADFD3C67C4BE52CAC748@DBDE04.ent.ti.com>
 <541A25DA.8030101@linaro.org> <541AE102.2070407@ti.com>
 <541AE314.5040107@ti.com> <54201DE3.6030207@ti.com>
Message-ID: <20140922131708.GA17009@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel,
On 08:02-20140922, Nishanth Menon wrote:
[...]
> >>Test #2: 1200 seconds: (http://fpaste.org/134564/47289141/)

Santosh wanted me to make certain that the following is noted;
^^ -> is around 20 mins. -> So highlighting again.. I assume this is
long enough test duration you requested for.

> >>CMD: set -x;uname -a;cat /sys/kernel/debug/pm_debug/count;sleep
> >>1;./cpuidle_killer_1200;sleep 1;cat
> >>/sys/kernel/debug/pm_debug/count;set +x
> >>
> >>OMAP4 Panda-ES: (2 a9) - not impacted as part of this patch - just
> >>base test vector
> >>http://fpaste.org/134563/41104728/
> >>
> >>OMAP5 uEVM: (2 a15)
> >>http://fpaste.org/134562/47221141/
> >>
> >>DRA74x EVM: (2 a15)
> >>http://fpaste.org/134559/11047098/
> >>
> >>DRA72 EVM: (2 a15)
> >	      ^^
> >Correction should have been 1 a15
> >
> >>http://fpaste.org/134560/11047151/
> >>
> >>AM572x EVM: (2 A15)
> >>http://fpaste.org/134561/47189141/
> >>
> >>
> 
> Daniel, Santosh: Gentle ping:
> 
> Any further comments? OR are we ok for this for being merged?
> 
-- 
Regards,
Nishanth Menon
