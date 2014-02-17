From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 17 Feb 2014 16:35:21 +0900
Subject: [PATCH] ARM: shmobile: Check MD21 at SMP boot in case of APMU
In-Reply-To: <20140217072111.GA23528@verge.net.au>
References: <20140217063152.21876.6981.sendpatchset@w520>
 <20140217072111.GA23528@verge.net.au>
Message-ID: <CANqRtoS7dKZcjcF3k6wq21UKmZG44txjbLfesmP+S4-tR0UNCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 4:21 PM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Feb 17, 2014 at 03:31:52PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> On R-Car Gen2 SoCs such as r8a7790 and r8a7791 the hardware boot
>> mode bit MD21 indicates if hardware debug mode is enabled or not.
>>
>> In case hardware debug mode is enabled print a warning and refrain
>> from booting secondary CPU cores. Without this patch Koelsch boards
>> with SW8-4 set to OFF will hang at SMP boot.
>
> Out of interest, is this the solution to your recent SMP troubles?

Yes, one of them. =)

/ magnus
