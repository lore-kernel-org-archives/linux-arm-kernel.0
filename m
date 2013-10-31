From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 31 Oct 2013 17:06:10 +0900
Subject: [PATCH 2/2] ARM: shmobile: Koelsch: add Ether support
In-Reply-To: <201310310219.58963.sergei.shtylyov@cogentembedded.com>
References: <201310310216.28673.sergei.shtylyov@cogentembedded.com>
 <201310310219.58963.sergei.shtylyov@cogentembedded.com>
Message-ID: <CANqRtoTa6-UP88146KPy9zNXNTRynBVqWZYb1k=0MK03NMJqhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Thu, Oct 31, 2013 at 8:19 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Register Ether platform device and pin data on  the  Koelsch board.
> Register platform fixup for Micrel KSZ8041 PHY, just like on the Lager board.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks for your patch. Just like on the Lager board we also need to
tie in the PHY IRQ pin. Polling is not good enough when the hardware
can do better. Can you please share your PHY IRQ plans with us?

Best,

/ magnus
