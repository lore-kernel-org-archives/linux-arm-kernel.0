From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Thu, 14 Apr 2016 17:28:34 +0900
Subject: [next] Failing Odroid XU3 boot due to missing MMC device
In-Reply-To: <570F5380.7010103@samsung.com>
References: <570F5380.7010103@samsung.com>
Message-ID: <570F54B2.2070704@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/14/2016 05:23 PM, Krzysztof Kozlowski wrote:
> Hi,> 
> 
> Anyone also observed recent failures of linux-next (20160413, 20160414)
> on booting from SD card? On my Odroid XU3 exynos and multi_v7 configs
> fail with:
> 
> Apr 14 07:52:53 starting version 229
> Apr 14 07:52:53 :: running hook [udev]
> Apr 14 07:52:53 :: Triggering uevents...
> Apr 14 07:52:54 Waiting 10 seconds for device /dev/mmcblk0p1 ...
> Apr 14 07:53:05 ERROR: device '/dev/mmcblk0p1' not found. Skipping fsck.
> Apr 14 07:53:05 ERROR: Unable to find root device '/dev/mmcblk0p1'.
> Apr 14 07:53:05 You are being dropped to a recovery shell
> Apr 14 07:53:05     Type 'exit' to try and continue booting
> Apr 14 07:53:05 sh: can't access tty; job control turned off
> 
> I didn't start bisecting yet... maybe this is known?

Refer to the below thread.

https://patchwork.kernel.org/patch/8769361/

Best Regards,
Jaehoon Chung

> 
> Full logs:
> http://www.krzk.eu/builders/boot-odroid-xu3-exynos/builds/673/steps/Boot%20odroid/logs/serial
> 
> 
> Best regards,
> Krzysztof
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
