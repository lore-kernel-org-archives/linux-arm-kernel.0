From: zhangfei.gao@linaro.org (zhangfei)
Date: Tue, 08 Dec 2015 11:28:20 +0800
Subject: [PATCH v2 4/9] ARM: dts: add dts files for hi3519-demb board
In-Reply-To: <56652912.80308@huawei.com>
References: <1449110668-23647-1-git-send-email-xuejiancheng@huawei.com>
 <1728470.0OiiXMcl88@wuerfel> <5660FA2E.6040601@huawei.com>
 <3047121.2z9SCS5Au2@wuerfel> <56652912.80308@huawei.com>
Message-ID: <56664E54.4040604@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/07/2015 02:37 PM, xuejiancheng wrote:

>> As this seems to be a standard part, we can also think about making a
>> high-level driver for in in drivers/soc rather than relying on the syscon
>> driver which we tend to use more for one-off devices with random register
>> layouts.
>>
>     Sorry. I didn't understand your meaning well and maybe I gave you a wrong description.
> Please allow me to clarify it again.
>     The "sysctrl" nodes here is just used for the "reboot" function. It is corresponding to
> the driver "drivers/power/reset/hisi-reboot.c". The compatible string in the driver is
> "hisilicon,sysctrl".


Pls try use drivers/power/reset/syscon-reboot.c

Thanks
