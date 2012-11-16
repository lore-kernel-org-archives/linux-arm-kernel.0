From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Fri, 16 Nov 2012 13:41:41 +0200
Subject: [PATCH 1/9] usb: chipidea: pci: mark platformdata as static and
 __devinitdata
In-Reply-To: <50A612CD.8040004@pengutronix.de>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
 <1352909950-32555-2-git-send-email-m.grzeschik@pengutronix.de>
 <87haop7tfi.fsf@ashishki-desk.ger.corp.intel.com>
 <50A612CD.8040004@pengutronix.de>
Message-ID: <87boex7p1m.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc Kleine-Budde <mkl@pengutronix.de> writes:

> On 11/16/2012 11:06 AM, Alexander Shishkin wrote:
>> Michael Grzeschik <m.grzeschik@pengutronix.de> writes:
>> 
>>> From: Marc Kleine-Budde <mkl@pengutronix.de>
>>>
>>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>> 
>> static yes, __devinitdata -- probably not. These structs are used
>> everywhere throughout the driver currently, not only at initialization
>> time.
>
> Yes, but a copy of the platform_data is used:

True, forgot about that. Apologies.

Regards,
--
Alex
