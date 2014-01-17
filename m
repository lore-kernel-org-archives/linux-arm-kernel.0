From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 17 Jan 2014 15:00:29 +0900
Subject: [PATCH 1/2] ARM: shmobile: Lager: pass Ether PHY IRQ
In-Reply-To: <201312200219.31121.sergei.shtylyov@cogentembedded.com>
References: <201312200218.08076.sergei.shtylyov@cogentembedded.com>
 <201312200219.31121.sergei.shtylyov@cogentembedded.com>
Message-ID: <CANqRtoQ_qPBJUqnbU6wrrc+tmsspk_v99w-ZTdnhPivEdBzd4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 8:19 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Pass Ether's PHY IRQ (which is IRQC's IRQ0) to the 'sh_eth' driver. Set the IRQ
> trigger type to be low-level as per the Micrel PHY driver's setup.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
>  arch/arm/mach-shmobile/board-lager.c |    4 ++++
>  1 file changed, 4 insertions(+)

Thanks for your efforts. The code looks fine. I have now also tested
this on my Lager board.

Acked-by: Magnus Damm <damm@opensource.se>

Cheers,

/ magnus
