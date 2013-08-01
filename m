From: B44344@freescale.com (Goel Arpit-B44344)
Date: Thu, 1 Aug 2013 09:26:43 +0000
Subject: [PATCH 2/2] Convert PowerPC macro spin_event_timeout() to
 architecture independent macro
In-Reply-To: <51F9A5FE.8030608@codeaurora.org>
References: <1375187900-17582-1-git-send-email-B44344@freescale.com>
 <1375187900-17582-3-git-send-email-B44344@freescale.com>
 <20130731071630.GI8868@codeaurora.org>
 <CAOZdJXVvNBR-qf7LXNOHZVstH_Rebxwn-wAkSaBS53Wn55mYCw@mail.gmail.com>
 <51F9A5FE.8030608@codeaurora.org>
Message-ID: <0DFB48290CDB0C4680160EBE62E8F9A809E9B38B@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thursday, August 01, 2013 5:34 AM Stephen Boyd [mailto:sboyd at codeaurora.org] wrote:
> BTW, couldn't we skip the first patch and just use usecs_to_jiffies()?

[Arpit] It is a good idea to use usecs_to_jiffies() in spin_event_timeout() implementation. But wont moving USECS_PER_JIFFY from
	  C <arch/time.c> files to include <arch/timex.h> files also required as this would enable using USECS_PER_JIFFY. 	

--
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
