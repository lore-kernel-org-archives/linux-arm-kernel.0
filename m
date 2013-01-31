From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 31 Jan 2013 15:21:42 +0530
Subject: [PATCH RFC] davinci: poll for sleep completion in resume routine.
In-Reply-To: <1359624393-5898-1-git-send-email-manishv.b@ti.com>
References: <1359624393-5898-1-git-send-email-manishv.b@ti.com>
Message-ID: <510A3EAE.107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 1/31/2013 2:56 PM, Vishwanathrao Badarkhe, Manish wrote:
> As per OMAP-L138 TRM, Software must poll for
> SLEEPCOMPLETE bit until it is set to 1 before clearing
> SLEEPENABLE bit in DEEPSLEEP register in resume routine.
> Modifications are as per datasheet:
> http://www.ti.com/lit/ug/spruh77a/spruh77a.pdf
> See sections 10.10.2.2 and 11.5.21 for more detailed
> explanation.
> 
> Tested on da850-evm.
> 
> Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>

Is this a bug fix? Do you see any issue without this patch?

Thanks,
Sekhar
