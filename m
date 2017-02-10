From: gpkulkarni@gmail.com (Ganapatrao Kulkarni)
Date: Fri, 10 Feb 2017 11:36:36 +0530
Subject: [PATCH v14 0/6] Enable PMUs in ACPI systems
In-Reply-To: <cea38f4f-4696-baab-b539-f9d0a8db3f42@linaro.org>
References: <1485210765-9422-1-git-send-email-jeremy.linton@arm.com>
 <cea38f4f-4696-baab-b539-f9d0a8db3f42@linaro.org>
Message-ID: <CAFpQJXVjMuEKE-LqN57v8Txzj6A=Hccj07XWbBaR_dRgiCLNQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 1:19 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>
>
> On 2017/1/24 6:32, Jeremy Linton wrote:
>>
>> This patch expands and reworks the patches published by Mark Salter
>> in order to clean up a few of the previous review comments, as well as
>> add support for newer CPUs and big/little configurations.
>>
>> v14:
>> - drop rename patch requested for v6
>> - Shuffle couple include lines from one patch to a later
>>   patch.
>
>
> Test again on D03 and works fine as before,
>
> Tested-by: Hanjun Guo <hanjun.guo@linaro.org>
>
> Hanjun

Tested this series on Cavium's ThunderX2 CN99XX platform.

Tested-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>

thanks
Ganapat
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
