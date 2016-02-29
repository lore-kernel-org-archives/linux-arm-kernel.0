From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 29 Feb 2016 12:34:55 -0300
Subject: Booting MX7Solo with 4.5-rc6
In-Reply-To: <AMSPR04MB263126AA78BEE3D8818F80388BA0@AMSPR04MB263.eurprd04.prod.outlook.com>
References: <CAOMZO5A6AO1n+fiwYBa=7VS3i1qk6zZ_ifym1yPt6+ApcTAuoA@mail.gmail.com>
 <AMSPR04MB263126AA78BEE3D8818F80388BA0@AMSPR04MB263.eurprd04.prod.outlook.com>
Message-ID: <CAOMZO5BX4+AB59SGCUGyk2RKyi706wOxgMp15beyGR9Dg6HWPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 12:23 PM, Frank Li <frank.li@nxp.com> wrote:
>
>
>> -----Original Message-----
>> From: Fabio Estevam [mailto:festevam at gmail.com]
>> Sent: Monday, February 29, 2016 8:23 AM
>> To: Frank Li <frank.li@nxp.com>; Hui Liu <jason.hui.liu@nxp.com>
>> Cc: Peng Fan <peng.fan@nxp.com>; linux-arm-kernel at lists.infradead.org;
>> Dong Aisheng <dongas86@gmail.com>
>> Subject: Booting MX7Solo with 4.5-rc6
>>
>> Hi,
>>
>> I am trying to boot linux-next 20160229 on a m7solo warp board and this is
>> what I get:
>>
>> http://pastebin.com/TmQdqd2B
>>
>> I can boot this board fine using NXP 3.14.52 kernel.
>>
>> These clock warnings also happen on a mx7d sabresd board, but the boot
>> proceed fine.
>
> It caused usleep_range(50, 500) in clk_pllv3_wait_lock.
> Need aisheng's patch to fix it.

Yes, I know, but they should not prevent the boot from happening.

>> Any ideas as to what needs to be done in order to boot a MX7S?
>
> Can you try to disable arch_timer in dts?

Just disabled it, but it did not help. Thanks
