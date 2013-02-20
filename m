From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 20 Feb 2013 21:14:25 +0530
Subject: [PATCH 6/8] SERIAL: OMAP: Remove the slave idle handling from
 the driver
In-Reply-To: <87sj4rqa7r.fsf@linaro.org>
References: <1361354444-18230-1-git-send-email-santosh.shilimkar@ti.com>
 <87sj4rqa7r.fsf@linaro.org>
Message-ID: <5124EF59.5080206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 20 February 2013 08:54 PM, Kevin Hilman wrote:
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> UART IP slave idle handling now taken care by runtime pm backend(hwmod layer)
>> so remove the hackery from the driver.
>>
>> Tested-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
>> Tested-by: Sourav Poddar <sourav.poddar@ti.com>
>> Signed-off-by: Rajendra nayak <rnayak@ti.com>
>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
>> ---
>>   drivers/tty/serial/omap-serial.c |   23 -----------------------
>>   1 file changed, 23 deletions(-)
>
> This patch should also remove the hooks from
> <linux/platform_data/serial-omap.h>
>
Right. Will fix that in next version. Thanks.

Regards,
Santosh
