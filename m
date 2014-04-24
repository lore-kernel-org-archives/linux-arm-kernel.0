From: nm@ti.com (Nishanth Menon)
Date: Thu, 24 Apr 2014 11:06:33 -0500
Subject: [PATCH V2 00/19] bus: omap_l3_noc: driver cleanups and support
 for DRA7/AM4372
In-Reply-To: <20140424155403.GA29229@ti.com>
References: <1397492726-17203-1-git-send-email-nm@ti.com>
 <1397767775-10965-1-git-send-email-nm@ti.com> <20140424155403.GA29229@ti.com>
Message-ID: <53593689.3060801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2014 10:54 AM, Darren Etheridge wrote:
> Nishanth,
> 
> Nishanth Menon <nm@ti.com> wrote on Thu [2014-Apr-17 15:49:16 -0500]:
>>
>> V2 introduces the following changes:
>> 	- Additional bug fix detected during additional testing (all tests complete now). patch #12
>> 	- reordering of patches to order logical changes and reduce code churn.
>> 	- interrupt handler split up and additional information now provided in log to aid debug when error occur
>> 	- patches are marked where new (12,14,15,16).
>> 	- DRA7 updated from master document for all DRA7 variants.
>>
>> This series cleansup omap_l3_noc driver and adds data to support DRA7
>> and AM437x SoCs.
>>
> This L3 noc driver patch series is working great for me and has already
> flagged a very difficult to detect problem in a driver I am working on
> with a DMA access to an invalid memory address on DRA7.

Glad it was of use. All the more reason why this should be in upstream
kernel and not just in "evil vendor" kernel.

> 
> Tested-by: Darren Etheridge <detheridge@ti.com>
> 
Thanks. will pick this up for v3 post.


-- 
Regards,
Nishanth Menon
