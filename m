From: van.freenix@gmail.com (Peng Fan)
Date: Fri, 29 Dec 2017 08:39:56 +0800
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: select CONFIG_RTC_DRV_SNVS
In-Reply-To: <CAJKOXPcda4s-H=Ks5hby950Ecybj2yp_WQj4PNja2d_fn_eMrQ@mail.gmail.com>
References: <1514453660-15373-1-git-send-email-peng.fan@nxp.com>
 <CAJKOXPcda4s-H=Ks5hby950Ecybj2yp_WQj4PNja2d_fn_eMrQ@mail.gmail.com>
Message-ID: <20171229003956.GA17906@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 28, 2017 at 02:02:07PM +0100, Krzysztof Kozlowski wrote:
>On Thu, Dec 28, 2017 at 10:34 AM, Peng Fan <peng.fan@nxp.com> wrote:
>> Select CONFIG_RTC_DRV_SNVS for i.MX6 to use RTC to wakeup system
>> Patch generated with:
>>         make ARCH=arm multi_v7_defconfig
>>         select CONFIG_RTC_DRV_SNVS
>>         make savedefconfig
>
>No. You are doing hundreds of changes just to enable one option. There
>is no way to review this...
>
>Instead if you need to cleanup the defconfig, first do this in
>separate step without any other changes.
>
>Then send a patch adding necessary options.

ok. I'll use make ARCH=arm multi_v7_defconfig; make savedefconfig first
to cleanup the defconfig. Then use a new patch to select the option.

Thanks,
Peng.

>
>Best regards,
>Krzysztof

-- 
