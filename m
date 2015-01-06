From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 06 Jan 2015 19:17:23 +0800
Subject: [PATCH v6 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
In-Reply-To: <54AB894C.9010001@huawei.com>
References: <1420368918-5086-1-git-send-email-hanjun.guo@linaro.org>
 <54AB894C.9010001@huawei.com>
Message-ID: <54ABC443.2070502@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?01?06? 15:05, Yijing Wang wrote:
> On 2015/1/4 18:55, Hanjun Guo wrote:
>> Hi,
>
> Hello Hanjun,
>
> We tested your v5 patch set (and added some GICv3 patches) on Hisilicon ARM64 SoC hardware,
> from your change log for v6,  there is only one functional change to fix the NULL pointer, I think
> the test result is still valid for v6, please refer to the test result below [1].
>
> We can boot the system successfully using PSCI on our ARM64 hardware using this patch set, of course
> we need to add some more patches (GICv3), but with this patch set:
>
> You could add my Tested-by: Yijing Wang <wangyijing@huawei.com> if you want.

Great, thanks a lot!

>
> if you want me to test the new version of patch set, please let me know, thanks.

if you have some free time, please help me to do that :)

Thanks
Hanjun
