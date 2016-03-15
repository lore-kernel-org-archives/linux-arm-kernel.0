From: moritz.fischer@ettus.com (Moritz Fischer)
Date: Tue, 15 Mar 2016 10:50:23 -0700
Subject: [PATCH 1/7] dmaengine: xilinx_vdma: Fix checkpatch.pl warnings
In-Reply-To: <1458062592-27981-2-git-send-email-appanad@xilinx.com>
References: <1458062592-27981-1-git-send-email-appanad@xilinx.com>
 <1458062592-27981-2-git-send-email-appanad@xilinx.com>
Message-ID: <CAAtXAHdzgt2uXo4_BV4wbGyAbseF7JcbWf8on-KzmcDWnK+WPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patch looks fine to me.

On Tue, Mar 15, 2016 at 10:23 AM, Kedareswara rao Appana
<appana.durga.rao@xilinx.com> wrote:
> This patch fixes the below checkpatch.pl warnings.
>
> WARNING: void function return statements are not generally useful
> +       return;
> +}
>
> WARNING: void function return statements are not generally useful
> +       return;
> +}
>
> WARNING: Missing a blank line after declarations
> +               u32 errors = status & XILINX_VDMA_DMASR_ALL_ERR_MASK;
> +               vdma_ctrl_write(chan, XILINX_VDMA_REG_DMASR,
>
Acked-by: Moritz Fischer <moritz.fischer@ettus.com>

> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>

Cheers,

Moritz
