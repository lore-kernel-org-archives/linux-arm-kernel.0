From: paweljarosz3691@gmail.com (=?UTF-8?Q?Pawe=c5=82_Jarosz?=)
Date: Wed, 5 Oct 2016 08:09:17 +0200
Subject: [PATCH] ARM: dts: rockchip: Reserve unusable memory region on
 rk3066
In-Reply-To: <6239b970-09d3-f7ee-e6f5-c019eaedb725@rock-chips.com>
References: <20161001140939.GA31220@vaio-ubuntu>
 <6239b970-09d3-f7ee-e6f5-c019eaedb725@rock-chips.com>
Message-ID: <f8aba48d-6c69-b246-4cb2-48a2770c80e4@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi


W dniu 05.10.2016 o 04:27, Huang, Tao pisze:
> Hi, Pawe?:
> On 2016?10?01? 22:09, =?UTF-8?q?Pawe=C5=82=20Jarosz?= wrote:
>> For some reason accessing memory region above 0xfe000000 freezes
>> system on rk3066. There is similiar bug on later rockchip soc (rk3288)
> RK3066 only support 2GB memory from 0x60000000 to 0xE0000000, can not access
> above 0xfe000000. I think you mean 0x9F000000?
Yes i meant 0x9F00000. Sorry for that.
> I don't remember RK3066 has such limit. I will double check with our IC
> design team.
> Do you know which master can not access this memory area
> [0x9F000000~0xA0000000)?
I don't.
> Could you please tell which board you're using (and how much memory it has)
Rikomagic MK808 1GB RAM

Thanks
Pawel
