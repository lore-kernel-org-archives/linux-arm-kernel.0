From: paweljarosz3691@gmail.com (=?UTF-8?Q?Pawe=c5=82_Jarosz?=)
Date: Mon, 10 Oct 2016 11:11:09 +0200
Subject: [PATCH] ARM: dts: rockchip: Reserve unusable memory region on
 rk3066
In-Reply-To: <67831fd0-76af-a793-0b2f-958e45633fe8@rock-chips.com>
References: <20161001140939.GA31220@vaio-ubuntu>
 <6239b970-09d3-f7ee-e6f5-c019eaedb725@rock-chips.com>
 <f8aba48d-6c69-b246-4cb2-48a2770c80e4@gmail.com>
 <67831fd0-76af-a793-0b2f-958e45633fe8@rock-chips.com>
Message-ID: <149df5ee-3478-6d15-bb76-47becac146e9@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi


W dniu 10.10.2016 o 09:18, Huang, Tao pisze:
> Our IC guy need us tell them which master can not access such area, DMA
> or EMMC Controller or GPU, etc? Could you tell me how to reproduce such
> issue?
> And we can confirm CPU core can access this memory through /dev/mem and
> the test board is 1GB too. Personally, I don't think RK3066 has such
> limit because when we verify this chip, we don't found such limit at all.
>
> Thanks,
> Huang, Tao

I'm getting this on Ubuntu 16.04 with mainline kernel.
My board always freezes when i type: "memtester 800M"
