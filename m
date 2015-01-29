From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 29 Jan 2015 12:12:09 -0500
Subject: [PATCH] ARM: keystone: defconfig: add DEVTMPFS option by default.
In-Reply-To: <54CA6125.60507@oracle.com>
References: <1422544368-15861-1-git-send-email-m-karicheri2@ti.com>
 <54CA6125.60507@oracle.com>
Message-ID: <54CA69E9.5090300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/29/2015 11:34 AM, santosh shilimkar wrote:
> On 1/29/2015 7:12 AM, Murali Karicheri wrote:
>> When using network driver on keystone and nfs rootfs is used following
>> error displayed and device halts.
>>
>> Missing devtmpfs, which is required for udev to run
>> Halting...
>>
> Must be with Ubuntu...
>
Not really. It was with TI rootfs.

-Murali
>> Add the DEVTMPFS option by default to fix this
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> ---
> Looks fine. I will queue it up for next merge window.
>
> Regards,
> Santosh
>
>


-- 
Murali Karicheri
Linux Kernel, Texas Instruments
