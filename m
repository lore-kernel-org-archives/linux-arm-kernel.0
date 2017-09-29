From: jon.mason@broadcom.com (Jon Mason)
Date: Fri, 29 Sep 2017 10:15:16 -0400
Subject: [PATCH v2 01/10] MAINTAINERS: Update Broadcom iProc regexp with
 Hurricane 2
In-Reply-To: <1506669761.29089.30.camel@perches.com>
References: <20170928231502.27069-1-f.fainelli@gmail.com>
 <20170928231502.27069-2-f.fainelli@gmail.com>
 <1506669761.29089.30.camel@perches.com>
Message-ID: <CAC3K-4qMLtUnjitn4CA+MxVeXZ03-AR0D+zANbZo-vR98S+Djw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 29, 2017 at 3:22 AM, Joe Perches <joe@perches.com> wrote:
> On Thu, 2017-09-28 at 16:14 -0700, Florian Fainelli wrote:
>> Update the Broadcom iProc regepx with recently added Hurricane 2 SoC
>> support.
>>
>> Acked-by: Jon Mason <jon.mason@broadcom.com>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  MAINTAINERS | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6671f375f7fc..3b48a1c2ddb8 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2923,6 +2923,7 @@ N:      bcm583*
>>  N:   bcm585*
>>  N:   bcm586*
>
> These don't match anything

This comment is outside the scope of this patch.  I'll do a clean-up
separate from this series to address the issue.

Thanks,
Jon

>
>>  N:   bcm88312
>> +N:   hr2
>>  F:   arch/arm64/boot/dts/broadcom/ns2*
>>  F:   drivers/clk/bcm/clk-ns*
>>  F:   drivers/pinctrl/bcm/pinctrl-ns*
