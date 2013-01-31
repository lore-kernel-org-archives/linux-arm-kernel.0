From: manishv.b@ti.com (Vishwanathrao Badarkhe, Manish)
Date: Thu, 31 Jan 2013 10:11:30 +0000
Subject: [PATCH RFC] davinci: poll for sleep completion in resume routine.
In-Reply-To: <510A3EAE.107@ti.com>
References: <1359624393-5898-1-git-send-email-manishv.b@ti.com>
 <510A3EAE.107@ti.com>
Message-ID: <A4887BF146CD57468F700B415D2F4701581C4A@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sekhar

On Thu, Jan 31, 2013 at 15:21:42, Nori, Sekhar wrote:
> 
> 
> On 1/31/2013 2:56 PM, Vishwanathrao Badarkhe, Manish wrote:
> > As per OMAP-L138 TRM, Software must poll for SLEEPCOMPLETE bit until 
> > it is set to 1 before clearing SLEEPENABLE bit in DEEPSLEEP register 
> > in resume routine.
> > Modifications are as per datasheet:
> > http://www.ti.com/lit/ug/spruh77a/spruh77a.pdf
> > See sections 10.10.2.2 and 11.5.21 for more detailed explanation.
> > 
> > Tested on da850-evm.
> > 
> > Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
> 
> Is this a bug fix? Do you see any issue without this patch?

This is not a bug fix. I have not seen any issue without this patch. 
Only, modifications are done as per OMAP-L138 TRM.   

> 
> Thanks,
> Sekhar
> 


Regards, 
Manish
