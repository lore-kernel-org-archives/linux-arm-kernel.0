From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Thu, 29 Jan 2015 09:18:20 -0800
Subject: [PATCH] ARM: keystone: defconfig: add DEVTMPFS option by default.
In-Reply-To: <54CA69E9.5090300@ti.com>
References: <1422544368-15861-1-git-send-email-m-karicheri2@ti.com>
 <54CA6125.60507@oracle.com> <54CA69E9.5090300@ti.com>
Message-ID: <54CA6B5C.5090909@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/29/2015 9:12 AM, Murali Karicheri wrote:
> On 01/29/2015 11:34 AM, santosh shilimkar wrote:
>> On 1/29/2015 7:12 AM, Murali Karicheri wrote:
>>> When using network driver on keystone and nfs rootfs is used following
>>> error displayed and device halts.
>>>
>>> Missing devtmpfs, which is required for udev to run
>>> Halting...
>>>
>> Must be with Ubuntu...
>>
> Not really. It was with TI rootfs.
>
OK. In past I haven't noticed issue with undev for busybox based
rootfs but may be things have changed now. Typically it use to
be Ubuntu udev which use to crib. Thanks for information.

Regards,
Santosh
