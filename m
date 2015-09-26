From: bp@alien8.de (Borislav Petkov)
Date: Sat, 26 Sep 2015 10:38:47 +0200
Subject: [PATCH] edac: xgene: Fix possible sprintf overflow issue
In-Reply-To: <CAPw-ZTmYEx9o39Xr_4wyQd_ZNhpQv6fmjsbmzw7J27+i2nADqQ@mail.gmail.com>
References: <1443116287-11752-1-git-send-email-lho@apm.com>
 <20150925134551.GE3568@pd.tnic>
 <CAPw-ZTmYEx9o39Xr_4wyQd_ZNhpQv6fmjsbmzw7J27+i2nADqQ@mail.gmail.com>
Message-ID: <20150926083847.GA19534@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 25, 2015 at 10:52:23AM -0700, Loc Ho wrote:
> Thanks you... Next I would like to get the ACPI APEI supported. But
> unlike x86 which as NMI interface, APM hardware don't support this NMI
> interface. In order to make this works, we need an method to trigger
> the OS to indicate that the APEI table is available. For this, we are
> thinking about writing an separate APEI driver that wires up the IRQ
> to trigger the OS. Before we get going with this, I would like to run
> by you to see if you have any suggestion?

Well, AFAIR, there are efforts going on already for this on ARM64:

https://lkml.kernel.org/r/1439555753-11974-1-git-send-email-fu.wei at linaro.org

Maybe test those first and possibly extend...

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
