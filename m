From: d-gerlach@ti.com (Dave Gerlach)
Date: Mon, 14 Jul 2014 12:47:35 -0500
Subject: [PATCH v4 00/11] ARM: OMAP2+: AM33XX: Add suspend-resume support
In-Reply-To: <20140714112412.GE20068@atomide.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
 <20140714112412.GE20068@atomide.com>
Message-ID: <53C417B7.5050800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

On 07/14/2014 06:24 AM, Tony Lindgren wrote:
> * Dave Gerlach <d-gerlach@ti.com> [140710 19:58]:
>> Hello,
>>
>> This series adds suspend/resume support for am335x. Version 3 of this
>> series can be found at [1]. I apologize for the large delay between this
>> and the previous revision. This code has been heavily refined
>> since the last version based on the various comments received for v3. The
>> major change from previous version is moving all wkup_m3 code into a
>> remoteproc based driver. The new driver handles all IPC and fw loading
>> and exposes a small API to be used by PM code to achieve low power states.
>
> Great, this is nice for all the am335x users. I made few comments
> on the series that should be quite simple to fix up.
>
> Then please split up your next version of this series into the
> following independet patches:
>
> 1. Changes to the EDMA driver for suspend and resume support
>
> 2. Patches to add the rproc driver
>
> 3. SoC related changes to enable PM support
>

Thanks for the feedback. I will give some more time for additional comments and 
then revise, split, and resend.

Regards,
Dave

> Regards,
>
> Tony
>
