From: laurentiu.tudor@nxp.com (Laurentiu Tudor)
Date: Fri, 3 Nov 2017 15:38:08 +0000
Subject: [PATCH v2] staging: fsl-mc: move bus driver out of staging
In-Reply-To: <20171103151711.GA22453@kroah.com>
References: <20170828105405.19552-1-laurentiu.tudor@nxp.com>
 <20170831160430.GB11200@kroah.com> <20171103151711.GA22453@kroah.com>
Message-ID: <59FC8D60.6030708@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On 11/03/2017 05:17 PM, Greg KH wrote:
> On Thu, Aug 31, 2017 at 06:04:30PM +0200, Greg KH wrote:
>> On Mon, Aug 28, 2017 at 01:54:05PM +0300, laurentiu.tudor at nxp.com wrote:
>>> From: Stuart Yoder <stuart.yoder@nxp.com>
>>>
>>> Move the source files out of staging into their final locations:
>>>    -include files in drivers/staging/fsl-mc/include go to include/linux/fsl
>>>    -irq-gic-v3-its-fsl-mc-msi.c goes to drivers/irqchip
>>>    -source in drivers/staging/fsl-mc/bus goes to drivers/bus/fsl-mc
>>>    -README.txt, providing and overview of DPAA goes to
>>>     Documentation/dpaa2/overview.txt
>>>
>>> Update or delete other remaining staging files-- Makefile, Kconfig, TODO.
>>> Update dpaa2_eth and dpio staging drivers.
>>>
>>> Signed-off-by: Stuart Yoder <stuyoder@gmail.com>
>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>>> [Laurentiu: rebased, add dpaa2_eth and dpio #include updates]
>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>> Cc: Jason Cooper <jason@lakedaemon.net>
>>> Cc: Marc Zyngier <marc.zyngier@arm.com>
>>
>> This is going to have to wait until I get a chunk of time to do the
>> review.  Probably after 4.13-final is out.
>
> Ok, review comments as I go through the code:

Thanks a lot for taking the time. I'll take care of the comments next week.

---
Best Regards, Laurentiu
