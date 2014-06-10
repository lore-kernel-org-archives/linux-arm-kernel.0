From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 10 Jun 2014 13:14:27 +0900
Subject: [PATCH v2] ARM: shmobile: koelsch: Add support HSCIF1
In-Reply-To: <1402367659-21117-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
References: <1402367659-21117-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Message-ID: <CANqRtoT9OjX--sh3ab1R-j=ommqU3vvh1EzDoNQfkwZL39FSZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Iwamatsu-san,

On Tue, Jun 10, 2014 at 11:34 AM, Nobuhiro Iwamatsu
<nobuhiro.iwamatsu.yj@renesas.com> wrote:
> Koelsch can use HSCIF1 insetead of SCIF1 as serial port. But if we want to
> use, we will need to disable the GPIO key and remodeling of the board.
> Therefore status of hscif1 does not set the "okay".
>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
>  V2: Remove hscif1_clk from renesas,groups. This pin does not use.

Thanks for updating the patch. This looks fine to me.

Acked-by: Magnus Damm <damm+renesas@opensource.se>

Cheers,

/ magnus
