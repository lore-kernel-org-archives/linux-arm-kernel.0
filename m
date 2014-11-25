From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 25 Nov 2014 15:31:40 +0800
Subject: [PATCH] ARM: multi_v7_defconfig: add driver support for hix5hd2
In-Reply-To: <37901649.5ex6yEbcJj@wuerfel>
References: <1416750822-26305-1-git-send-email-zhangfei.gao@linaro.org>
 <37901649.5ex6yEbcJj@wuerfel>
Message-ID: <5474305C.4090303@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd

On 11/24/2014 10:06 PM, Arnd Bergmann wrote:
> On Sunday 23 November 2014 21:53:42 Zhangfei Gao wrote:
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>> ---
>>   arch/arm/configs/multi_v7_defconfig |    7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>
> The patch looks good, but the changeset description is missing.
>
> - What level of testing has been done on this (compile, boot, some
>    testsuite, ...)?
>
> - What do you expect to happen with the patch? Do you want review
>    or should someone pick it up?
>

The patch has been verified on hix5hd2 platform with mmc, usb & network.
Will add this info.

It is great if you directly pick it up.

Thanks
