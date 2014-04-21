From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 21 Apr 2014 02:56:41 +0200
Subject: [PATCH v3 1/4] MAINTAINERS: Add entry for APM X-Gene SoC ethernet
 driver
In-Reply-To: <1397704685.14062.14.camel@joe-AO725>
References: <1397702368-4846-1-git-send-email-isubramanian@apm.com>
 <1397702368-4846-2-git-send-email-isubramanian@apm.com>
 <1397704685.14062.14.camel@joe-AO725>
Message-ID: <CABxcv=mj+phHmyg2U2jW51mLTwBN9Au791m-GtqU5BXDPy7Gtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Lyappan,

On Thu, Apr 17, 2014 at 5:18 AM, Joe Perches <joe@perches.com> wrote:
> On Wed, 2014-04-16 at 19:39 -0700, Iyappan Subramanian wrote:
>> This patch adds a MAINTAINERS entry for APM X-Gene SoC
>> ethernet driver.
> []
>> diff --git a/MAINTAINERS b/MAINTAINERS
> []
>> @@ -686,6 +686,14 @@ S:       Maintained
>>  F:   drivers/net/appletalk/
>>  F:   net/appletalk/
>>
>> +APPLIED MICRO (APM) X-GENE SOC ETHERNET DRIVER
>> +M:   Iyappan Subramanian <isubramanian@apm.com>
>> +M:   Keyur Chudgar <kchudgar@apm.com>
>> +M:   Ravi Patel <rapatel@apm.com>
>> +S:   Maintained
>> +F:   drivers/net/ethernet/apm/xgene
>
> Please add a terminating slash to show this is a directory.
>
> F:      drivers/net/ethernet/apm/xgene/
>

Also if you are maintaining this driver as a part of your daily work
(i.e: actually being paid for it by your company) the status should be
"Supported" instead.

If you are doing it on your own time but still using your company
email address then "Maintained" is correct.

Best regards,
Javier
