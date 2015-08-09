From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Sun, 09 Aug 2015 22:23:30 +0530
Subject: [PATCH-v5 5/5] i2c: pxa: Add ILCR (tLow & tHigh) configuration
 support
In-Reply-To: <87bnegk632.fsf@belgarion.home>
References: <1437482466-16126-1-git-send-email-vaibhav.hiremath@linaro.org>	<1437482466-16126-6-git-send-email-vaibhav.hiremath@linaro.org>	<55C1CE8E.9000601@linaro.org>
 <87bnegk632.fsf@belgarion.home>
Message-ID: <55C7858A.5080308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Sunday 09 August 2015 05:48 PM, Robert Jarzmik wrote:
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> writes:
>
>> Robert,
>>
>> It would be helpful if you can test this patch-series and confirm that
>> it now fixes the NULL pointer deference issue.
> Tested, it works on pxa27x in master mode, in non-DT mode.
>
> For all non-DT patches, you can add my :
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
>

Thanks Robert,

Wolfram,
Request you to please take a look at this series.
We can have discussion on DT properties as well.

Thanks,
Vaibhav
