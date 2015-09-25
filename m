From: lho@apm.com (Loc Ho)
Date: Fri, 25 Sep 2015 10:52:23 -0700
Subject: [PATCH] edac: xgene: Fix possible sprintf overflow issue
In-Reply-To: <20150925134551.GE3568@pd.tnic>
References: <1443116287-11752-1-git-send-email-lho@apm.com>
 <20150925134551.GE3568@pd.tnic>
Message-ID: <CAPw-ZTmYEx9o39Xr_4wyQd_ZNhpQv6fmjsbmzw7J27+i2nADqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

>
> All 5 applied.
>
> I've merged the last hunk changing xgene_edac_l3_create_debugfs_nodes
> into the second patch which adds the L3 support.


Thanks you... Next I would like to get the ACPI APEI supported. But
unlike x86 which as NMI interface, APM hardware don't support this NMI
interface. In order to make this works, we need an method to trigger
the OS to indicate that the APEI table is available. For this, we are
thinking about writing an separate APEI driver that wires up the IRQ
to trigger the OS. Before we get going with this, I would like to run
by you to see if you have any suggestion?

-Loc
