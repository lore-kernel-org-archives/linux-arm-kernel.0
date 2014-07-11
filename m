From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 11 Jul 2014 12:24:22 -0500
Subject: [PATCH v4 00/11] ARM: OMAP2+: AM33XX: Add suspend-resume support
In-Reply-To: <53BF996E.8020801@zonque.org>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
 <53BF996E.8020801@zonque.org>
Message-ID: <53C01DC6.9040804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2014 02:59 AM, Daniel Mack wrote:
> On 07/11/2014 04:55 AM, Dave Gerlach wrote:
>> This series adds suspend/resume support for am335x. Version 3 of this
>> series can be found at [1]. I apologize for the large delay between this
>> and the previous revision. This code has been heavily refined
>> since the last version based on the various comments received for v3. The
>> major change from previous version is moving all wkup_m3 code into a
>> remoteproc based driver. The new driver handles all IPC and fw loading
>> and exposes a small API to be used by PM code to achieve low power states.
>
> Thanks a lot for this new series, Dave!
>
> I've given it a quick test on a custom AM335x board and can confirm
> success. Tested with both DDR2 and DDR3 versions, both work fine, and
> power consumption drops to a reasonable level.
>

I appreciate you trying it out!

Regards,
Dave

> I'd be very happy if these patches made it in for 3.17, but I haven't
> followed the discussion on the patches this set depends on.
>
>
> Best regards,
> Daniel
>
