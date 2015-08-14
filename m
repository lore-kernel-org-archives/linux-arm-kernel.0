From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Fri, 14 Aug 2015 20:25:45 +0300
Subject: [RFT PATCH] arm: collie_defconfig: convert to use libata PATA
 drivers
In-Reply-To: <1439571876-13758-6-git-send-email-b.zolnierkie@samsung.com>
References: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
 <1439571876-13758-6-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <CALT56yO0Z3hs4CGAmT_Qtpc8482cUzK_GMROjQ=_4+rOJs0TBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-08-14 20:04 GMT+03:00 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>:
> IDE subsystem has been deprecated since 2009 and the majority
> (if not all) of Linux distributions have switched to use
> libata for ATA support exclusively.  However there are still
> some users (mostly old or/and embedded non-x86 systems) that
> have not converted from using IDE subsystem to libata PATA
> drivers.  This doesn't seem to be good thing in the long-term
> for Linux as while there is less and less PATA systems left
> in use:
>
> * testing efforts are divided between two subsystems
>
> * having duplicate drivers for same hardware confuses users
>
> This patch converts collie_defconfig to use libata PATA
> drivers.
>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Acked-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>


-- 
With best wishes
Dmitry
