From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 20 Mar 2018 19:22:08 +0530
Subject: =?UTF-8?Q?Re:_[PATCH_v8_00/42]_ARM:_davinci:_convert_to_common_cloc?=
 =?UTF-8?Q?k_framework=e2=80=8b?=
In-Reply-To: <152150722338.254778.4743967512266809482@swboyd.mtv.corp.google.com>
References: <1521168778-27236-1-git-send-email-david@lechnology.com>
 <152150722338.254778.4743967512266809482@swboyd.mtv.corp.google.com>
Message-ID: <4d6cc890-e948-6784-82bf-dac196804c07@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tuesday 20 March 2018 06:23 AM, Stephen Boyd wrote:
> Quoting David Lechner (2018-03-15 19:52:16)
>> This series converts mach-davinci to use the common clock framework.
>>
>> The series works like this, the first 19 patches create new clock drivers
>> using the common clock framework. There are basically 3 groups of clocks -
>> PLL, PSC and CFGCHIP (syscon). There are six different SoCs that each have
>> unique init data, which is the reason for so many patches.
> 
> Should I apply the first 19 patches to clk tree? Looking over them
> nothing stands out except for your self comment about the bad
> reviewed-by tag which I can remove.

I think it will be a good idea to go ahead merge the drivers/clk/ parts
for v4.17.

I have been traveling, and have not been able to review this version.
But I have closely reviewed previous versions. If there really are
issues, I am sure we can get follow-on patches to fix those.

But getting these into v4.17 will enable platform parts to come in
easily into v4.18

Thanks,
Sekhar
