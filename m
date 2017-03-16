From: tj@kernel.org (Tejun Heo)
Date: Thu, 16 Mar 2017 17:32:55 -0400
Subject: [PATCH v2 0/3] ATA/ARM: convert ARM/DaVinci to use libata PATA
 drivers
In-Reply-To: <1489509414-11491-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20170314163738epcas5p3db719229d59550476c918a15d8c16d63@epcas5p3.samsung.com>
 <1489509414-11491-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20170316213255.GF1480@htj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 05:36:51PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patchset adds Palmchip BK3710 IDE controller driver to
> libata and switches ARM/DaVinci to use it (instead of the old
> IDE driver).
> 
> Sekhar, please check that it still works after changes, thanks.
> 
> Changes since v1
> (https://www.spinics.net/lists/arm-kernel/msg567442.html):
> - addressed review comments from Sergei Shtylyov
> - fixed cycle_time unitialized variable issue
> 
> Changes since v0.1 draft patch version
> (https://www.spinics.net/lists/arm-kernel/msg566932.html):
> - fixed cycle_time build warning
> - added platform support fixes from Sekhar
> - added defconfig changes from Sekhar
> - preserved platform support for the old IDE driver
> - split it on 3 patches

Looks fine to me from libata side.  Once it gets tested, how should
the patches be routed?  I don't think it'd make sense to route them
separately.

Thanks.

-- 
tejun
