From: vitalywool@gmail.com (Vitaly Wool)
Date: Tue, 22 Dec 2009 09:53:52 +0300
Subject: [PATCH 10/10] ARM: PNX4008: get i2c clock rate from clk API
In-Reply-To: <083DF309106F364B939360100EC290F804F592E90A@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F592E90A@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <acd2a5930912212253w1c6d9296v4c68c0ad392c6fd5@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 22, 2009 at 2:23 AM, Kevin Wells <kevin.wells@nxp.com> wrote:

>
> Signed-off-by: Kevin Wells <kevin.wells@nxp.com>
>

Acked-by: Vitaly Wool <vitalywool@gmail.com>


> ---
>  arch/arm/mach-pnx4008/clock.c |    9 ++++++---
>  arch/arm/mach-pnx4008/i2c.c   |    9 ---------
>  drivers/i2c/busses/i2c-pnx.c  |   15 ++++-----------
>  include/linux/i2c-pnx.h       |    1 -
>  4 files changed, 10 insertions(+), 24 deletions(-)
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091222/3f238ecc/attachment-0001.htm>
