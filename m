From: monstr@monstr.eu (Michal Simek)
Date: Mon, 21 Jan 2013 19:55:11 +0100
Subject: [GIT PULL] arm-soc: Xilinx zynq serial changes for v3.9
In-Reply-To: <20130121183029.GA21326@kroah.com>
References: <CAHTX3dJGHK7nO2tx_kUWLwhpgNsCwtnjXAJnRFUOHVx2uE589Q@mail.gmail.com>
 <20130121183029.GA21326@kroah.com>
Message-ID: <CAHTX3d+2YgYqvMRFv=owxhF0Y_UGRn46d6ujMAcXTjzYT-9AvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/1/21 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Mon, Jan 21, 2013 at 06:19:03PM +0100, Michal Simek wrote:
>> Hi Arnd, Olof and Greg,
>>
>> I have two patches for xilinx uartps serial driver (the second one fix
>> one issue in the first one).
>> These patches has been sent to arm mailing list and also to
>> device-tree mailing list.
>>
>> There is a change in zynq dtsi that's why I think it can go through
>> arm-soc tree.
>> Please let me know if this should go through Greg serial tree.
>
> If they fix serial driver issues, I have no problem taking them through
> my serial tree, just send them on as patches and I will be glad to queue
> them up.

ok. I will add that two patches together because the second one fix
the first one
and will send just one to you.

Thanks,
Michal


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian
