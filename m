From: aneesh@ti.com (Aneesh V)
Date: Thu, 09 Feb 2012 19:50:30 +0530
Subject: [RFC PATCH 3/8] misc: emif: add register definitions for EMIF
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433179B3F3@DBDE01.ent.ti.com>
References: <331ABD5ECB02734CA317220B2BBEABC1317897B8@DBDE01.ent.ti.com>
 <B5906170F1614E41A8A28DE3B8D121433179B3F3@DBDE01.ent.ti.com>
Message-ID: <4F33D62E.8070403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 February 2012 04:55 PM, Bedia, Vaibhav wrote:
>> -----Original Message-----
>> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of V, Aneesh
>> Sent: Saturday, February 04, 2012 5:46 PM
>> To: linux-omap at vger.kernel.org
>> Cc: linux-kernel at vger.kernel.org; akpm at linux-foundation.org; V, Aneesh
>> Subject: [RFC PATCH 3/8] misc: emif: add register definitions for EMIF
>>
>
> Sorry for the delayed response. Can these register definitions be put in a place
> where the code from the arch/arm/mach-omap2/* can also access it?

I don't have any issues with it as long as everybody is in agreement.

>
> Devices like AM335x and TI814x will need to reconfigure the EMIF when coming out
> of low power states and putting these register definitions in a common place
> will help us avoid some code duplication.

Can you elaborate on that. Does EMIF lose its settings in low-power
mode? If so, are you going to do the re-initialization from internal
RAM or something? For us EMIF doesn't lose its state in low power modes.

br,
Aneesh
