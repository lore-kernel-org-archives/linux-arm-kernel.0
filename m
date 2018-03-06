From: d.schultz@phytec.de (Daniel Schultz)
Date: Tue, 6 Mar 2018 10:59:54 +0100
Subject: [PATCH] ARM: dts: rockchip: Add dp83867 CLK_OUT muxing
In-Reply-To: <2707703.8mZIocJ1Ne@diego>
References: <1520253911-46218-1-git-send-email-d.schultz@phytec.de>
 <3380975.Amu1WGHSQ5@diego> <2707703.8mZIocJ1Ne@diego>
Message-ID: <fe1d445e-e9ac-452f-e990-d4bc17bd3355@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On 03/05/2018 10:08 PM, Heiko St?bner wrote:
> Am Montag, 5. M?rz 2018, 21:25:30 CET schrieb Heiko St?bner:
>> Am Montag, 5. M?rz 2018, 13:45:11 CET schrieb Daniel Schultz:
>>> The CLK_O_SEL default is synchronous to XI input clock, which is 25 MHz.
>>> Set CLK_O_SEL to channel A transmit clock so we have 125 MHz on CLK_OUT.
>>>
>>> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
>> applied for 4.17
> had to move it to 4.18 though.
>
> The change to the dt-binding header goes through the networking
> tree and will only get merged for 4.17-rc1 .
>
> So devicetree changes in a different branch aren't available at this
> point.
>
> One commonly practiced alternative is that you provide a v2
> with the actual hex values instead of the constants for 4.17
> and a follow-up patch replacing them with the constants
> that I can apply for 4.18.
It's not so urgent because the RK818 PMIC currently does not boot and 
the patch for this problem is also pending.

-- 
Mit freundlichen Gr??en,
With best regards,
   Daniel Schultz
