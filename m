From: scott.branden@broadcom.com (Scott Branden)
Date: Thu, 17 Aug 2017 11:19:19 -0700
Subject: [PATCH 3/3] mfd: d1w: iproc: Add d1w driver
In-Reply-To: <20170817100206.tqb5kluje6nr27ob@dell>
References: <1502905525-5646-1-git-send-email-scott.branden@broadcom.com>
 <1502905525-5646-4-git-send-email-scott.branden@broadcom.com>
 <20170817100206.tqb5kluje6nr27ob@dell>
Message-ID: <b4704ec6-aace-4fa3-5bc4-1dc8433ce54d@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,


On 17-08-17 03:02 AM, Lee Jones wrote:
> On Wed, 16 Aug 2017, Scott Branden wrote:
>
>> From: Shreesha Rajashekar <shreesha@broadcom.com>
>>
>> d1w bus master controller is added as a mfd node.
> Why?
>
>> ds1wm driver is hooked to this node through the mfd framework.
> Why?
It looks like it was added under mfd as htc-pasic3.c is there
(other than htc-pasic3.c is and mfd due to gpio nodes).

Yes, bcm-iproc-d1w should move under w1 directory.
>
> What makes this an MFD device?
>
>> Signed-off-by: Shreesha Rajashekar <shreesha@broadcom.com>
>> Signed-off-by: Scott Branden <scott.branden@broadcom.com>
>> ---
>>   drivers/mfd/Kconfig         |  11 +++
>>   drivers/mfd/Makefile        |   1 +
>>   drivers/mfd/bcm-iproc-d1w.c | 202 ++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 214 insertions(+)
>>   create mode 100644 drivers/mfd/bcm-iproc-d1w.c
