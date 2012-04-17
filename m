From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 17 Apr 2012 09:46:58 +0800
Subject: [PATCH 13/13] clk: basic: improve parent_names & return errors
In-Reply-To: <CAJOA=zMPQK-W_nbRztXCNdLHoTJU73ZnrxAS8VvvmzgdaVS2mQ@mail.gmail.com>
References: <1334192572-12499-1-git-send-email-mturquette@linaro.org>
 <1334192572-12499-14-git-send-email-mturquette@linaro.org>
 <20120412064920.GH2445@S2101-09.ap.freescale.net>
 <CAJOA=zMPQK-W_nbRztXCNdLHoTJU73ZnrxAS8VvvmzgdaVS2mQ@mail.gmail.com>
Message-ID: <CAAQ0ZWRg2jwNZ7Bx5j5NtCVveT_085VmFtPMhWW62-aO+kFfnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 April 2012 07:10, Turquette, Mike <mturquette@ti.com> wrote:
...
> Yes, this was a braindead change on my part. ?I'll remove the kstrdup
> in my next series (the rest of this patch will stay in).
>
Do you have an ETA on that?  A few platform porting are waiting for a
stable branch with all necessary fixup/cleanup integrated to publish
the patches.

Regards,
Shawn
