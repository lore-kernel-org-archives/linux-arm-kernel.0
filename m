From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 17 Jan 2014 15:02:20 +0900
Subject: [PATCH 1/1] ARM: shmobile: Koelsch: pass Ether PHY IRQ
In-Reply-To: <201312200228.00555.sergei.shtylyov@cogentembedded.com>
References: <201312200226.38815.sergei.shtylyov@cogentembedded.com>
 <201312200228.00555.sergei.shtylyov@cogentembedded.com>
Message-ID: <CANqRtoT1bN4jYHA2+DYRzsVjXXMXRdR_9mqx3sUUXDhJAxe5Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 8:28 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Pass Ether's PHY IRQ (which is IRQC's IRQ0) to the 'sh_eth' driver. Set the IRQ
> trigger type to be low-level as per the Micrel PHY driver's setup.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
>  arch/arm/mach-shmobile/board-koelsch.c |    4 ++++
>  1 file changed, 4 insertions(+)

Thanks for this. The code looks good to me. I have now tested this on
my Koelsch board using ifconfig up/down and checking /proc/interrupts.

Acked-by: Magnus Damm <damm@opensource.se>

Cheers,

/ magnus
