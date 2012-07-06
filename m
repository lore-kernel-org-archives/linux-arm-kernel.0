From: johnhlinn@gmail.com (John Linn)
Date: Thu, 5 Jul 2012 17:00:14 -0700
Subject: FW: [PATCH 2/3] ARM: zynq: Add compatible entry for the ZC702
 board.
In-Reply-To: <f8b1a055-eb85-41c1-b08d-05ee0611b2b7@AM1EHSMHS020.ehs.local>
References: <f8b1a055-eb85-41c1-b08d-05ee0611b2b7@AM1EHSMHS020.ehs.local>
Message-ID: <CAB9O=CNiA+ypPYAGFKoxpW7BBL0Tg5Je+NF-+KOkqkrX2FTZuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 5, 2012 at 3:32 PM, John Linn <John.Linn@xilinx.com> wrote:
>
>
> -----Original Message-----
> From: Nick Bowler [mailto:nbowler at elliptictech.com]
> Sent: Wednesday, July 04, 2012 7:14 AM
> To: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Cc: Russell King; John Linn
> Subject: [PATCH 2/3] ARM: zynq: Add compatible entry for the ZC702
> board.
>
> This allows the kernel to start on this platform with the
> vendor-provided device tree blob.
>
> Signed-off-by: Nick Bowler <nbowler@elliptictech.com>
> Cc: John Linn <john.linn@xilinx.com>

Signed-off-by: John Linn <johnhlinn@gmail.com>

>
> ---
>  arch/arm/mach-zynq/common.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
> index 12a2984..a58c83b 100644
> --- a/arch/arm/mach-zynq/common.c
> +++ b/arch/arm/mach-zynq/common.c
> @@ -106,6 +106,7 @@ static void __init xilinx_map_io(void)
>
>  static const char *xilinx_dt_match[] = {
>         "xlnx,zynq-ep107",
> +       "xlnx,zynq-zc702",
>         NULL
>  };
>
> --
> 1.7.8.6
>
>
>
>
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
>
>
