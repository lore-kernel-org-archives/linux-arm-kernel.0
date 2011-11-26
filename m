From: a.zummo@towertech.it (Alessandro Zummo)
Date: Sat, 26 Nov 2011 21:16:39 +0100
Subject: [V1 3/3] RTC: sa1100: support sa1100, pxa and mmp soc families
In-Reply-To: <78895A20B3CF7D49B5589B604D36692B1A00C694BD@SC-VEXCH4.marvell.com>
References: <1322219217-1866-1-git-send-email-jtzhou@marvell.com>
 <201111251505.29823.arnd@arndb.de>
 <CAN1soZzfN2aNNH5Hmuv79Y-u-GR2Mnfh3oR2D2QWZNFV6-N+YQ@mail.gmail.com>
 <201111251719.39636.arnd@arndb.de>
 <20111125194221.66869a6f@linux.lan.towertech.it>
 <78895A20B3CF7D49B5589B604D36692B1A00C694BD@SC-VEXCH4.marvell.com>
Message-ID: <20111126211639.028b7433@linux.lan.towertech.it>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 26 Nov 2011 05:43:50 -0800
Jett Zhou <jtzhou@marvell.com> wrote:

> Hi Alessandro
> 	Do you mean that it check different id such as RTC_SA1100 and RTC_MMP in the driver?
> 	Actually, the Soc evolves SA1100->PXA->MMP, the RTC module are almost the same, except that the clock control of it is adjusted from MMP, so we distinguish it and do clk setting for MMP.

 No, I meant that your patch can go thru in the arch tree.

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
