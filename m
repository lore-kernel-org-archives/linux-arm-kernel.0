From: huangtao@rock-chips.com (Huang, Tao)
Date: Mon, 10 Oct 2016 15:18:34 +0800
Subject: [PATCH] ARM: dts: rockchip: Reserve unusable memory region on
 rk3066
In-Reply-To: <f8aba48d-6c69-b246-4cb2-48a2770c80e4@gmail.com>
References: <20161001140939.GA31220@vaio-ubuntu>
 <6239b970-09d3-f7ee-e6f5-c019eaedb725@rock-chips.com>
 <f8aba48d-6c69-b246-4cb2-48a2770c80e4@gmail.com>
Message-ID: <67831fd0-76af-a793-0b2f-958e45633fe8@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pawe?:
On 2016?10?05? 14:09, Pawe? Jarosz wrote:
> W dniu 05.10.2016 o 04:27, Huang, Tao pisze:
>> I don't remember RK3066 has such limit. I will double check with our IC
>> design team.
>> Do you know which master can not access this memory area
>> [0x9F000000~0xA0000000)?
> I don't.
>> Could you please tell which board you're using (and how much memory it has)
> Rikomagic MK808 1GB RAM
>
Our IC guy need us tell them which master can not access such area, DMA
or EMMC Controller or GPU, etc? Could you tell me how to reproduce such
issue?
And we can confirm CPU core can access this memory through /dev/mem and
the test board is 1GB too. Personally, I don't think RK3066 has such
limit because when we verify this chip, we don't found such limit at all.

Thanks,
Huang, Tao
