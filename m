From: r.sricharan@ti.com (R, Sricharan)
Date: Thu, 28 Jun 2012 17:28:14 +0530
Subject: [PATCH 2/4] ARM: OMAP2+: Move the stubbed prm and cm functions to
 prcm.c file and make them __weak.
In-Reply-To: <CAJ7qFSdiMgM3S5Q+XaFAGrgcL5M5f8CLHyKSRtBKu4AK6ei-BA@mail.gmail.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
 <1336669615-16454-3-git-send-email-r.sricharan@ti.com>
 <alpine.DEB.2.00.1205101140230.32719@utopia.booyaka.com>
 <CAJ7qFSdiMgM3S5Q+XaFAGrgcL5M5f8CLHyKSRtBKu4AK6ei-BA@mail.gmail.com>
Message-ID: <CAJ7qFSfu3yyj8YqETTzx+wipi1Nbf5m5fDLC26Tfojav+Lb56Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Ping..

Thanks,
 Sricharan

On Thu, Jun 14, 2012 at 5:26 PM, R, Sricharan <r.sricharan@ti.com> wrote:
> Hi Paul,
>
>>> Some prm and cm registers read/write and status functions
>>> are built only for some custom OMAP2+ builds and are stubbed
>>> in header files for other builds under ifdef statements.
>>> But this results in adding new CONFIG_ARCH_OMAPXXX
>>> checks when SOCs are added in the future. So move them
>>> to a common place for OMAP2+ and make them 'weak' implementations.
>>
>> Thanks for the patch. ?These stubs aren't needed any longer, so we can
>> just get rid of them; no need to mark them __weak. ?I've got a patch to
>> just drop them here to be posted soon as part of a larger PRCM cleanup.
>>
>>
> ?Is the PRCM cleanup series available now ?
>
> Thanks,
> ?Sricharan
