From: hotran@apm.com (Hoan Tran)
Date: Thu, 21 Jul 2016 15:21:11 -0700
Subject: [PATCH v3 2/3] hwmon: xgene: Add hwmon driver
In-Reply-To: <20160721220935.GB19236@roeck-us.net>
References: <1469134557-26869-1-git-send-email-hotran@apm.com>
 <1469134557-26869-3-git-send-email-hotran@apm.com>
 <20160721220935.GB19236@roeck-us.net>
Message-ID: <CAFHUOYzi48QkAp+Uw9yRSvcCrNPR5LKczDfb9r5t0fqZ0qVcFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Guenter,

On Thu, Jul 21, 2016 at 3:09 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, Jul 21, 2016 at 01:55:56PM -0700, Hoan Tran wrote:
>> This patch adds hardware temperature and power reading support for
>> APM X-Gene SoC using the mailbox communication interface.
>>
>> Signed-off-by: Hoan Tran <hotran@apm.com>
>> ---
>
> [ ... ]
>
>> +
>> +     dev_info(&pdev->dev, "APM X-Gene SoC HW monitor driver registered\n");
>> +
>> +     return rc;
>> +
>
> Nitpick: rc == 0 here, so return 0; is a better choice.
> Otherwise looks good.

Yes, I'll fix it then send v4 shortly.

>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> Note that I can not apply the patch at this time due to its dependency.

Thanks ! I'll let you know when Rafael applies that dependent patch
into linux-next.

Thanks
Hoan

>
> Guenter
