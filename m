From: bintian.wang@huawei.com (Bintian)
Date: Tue, 9 Jun 2015 10:30:47 +0800
Subject: [PATCH v9 5/6] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <557643EB.8000106@huawei.com>
References: <1432950661-23060-1-git-send-email-bintian.wang@huawei.com>
 <1432950661-23060-6-git-send-email-bintian.wang@huawei.com>
 <20150609005521.GA21682@tiger> <557643EB.8000106@huawei.com>
Message-ID: <55764FD7.2000805@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Hello Olof, Hello Kevin,

I checked the git log of Linux 4.1-rc7 from Linus, he says Linux 4.1
will have an rc8, so we may have time to review the following two pull
requests from Wei Xu?

[GIT PULL v2]Hisilicon 64-bit SoC changes for 4.2
[GIT PULL]Hisilicon 64-bit soc hi6220 DT changes for 4.2

Thanks for your time.

BR,

Bintian


On 2015/6/9 9:39, Bintian wrote:
> Hello Shawn,
>
> On 2015/6/9 8:55, Shawn Guo wrote:
>> A minor random comment below.
>>
>> On Sat, May 30, 2015 at 09:51:00AM +0800, Bintian Wang wrote:
>>> +        ao_ctrl: ao_ctrl {
>>> +            compatible = "hisilicon,hi6220-aoctrl", "syscon";
>>> +            reg = <0x0 0xf7800000 0x0 0x2000>;
>>> +            #clock-cells = <1>;
>>> +        };
>>> +
>>> +        sys_ctrl: sys_ctrl {
>>> +            compatible = "hisilicon,hi6220-sysctrl", "syscon";
>>> +            reg = <0x0 0xf7030000 0x0 0x2000>;
>>> +            #clock-cells = <1>;
>>> +        };
>>> +
>>> +        media_ctrl: media_ctrl {
>>> +            compatible = "hisilicon,hi6220-mediactrl", "syscon";
>>> +            reg = <0x0 0xf4410000 0x0 0x1000>;
>>> +            #clock-cells = <1>;
>>> +        };
>>> +
>>> +        pm_ctrl: pm_ctrl {
>>
>> An unit-address should be coded in the node name, when it has a 'reg'
>> property.
> Thanks for your suggestion, Rob also gives me the same suggestion :)
>
> In fact, I added the reg to node name in the "[GIT PULL]Hisilicon 64-bit
> soc hi6220 DT changes for 4.2", but it seems the pull is too late for
> kernel 4.2, I will prepare it for 4.3.
>
> Thanks,
>
> Bintian
>
>>
>> Shawn
>>
>>> +            compatible = "hisilicon,hi6220-pmctrl", "syscon";
>>> +            reg = <0x0 0xf7032000 0x0 0x1000>;
>>> +            #clock-cells = <1>;
>>> +        };
>>
>> .
>>
>
>
> .
>
