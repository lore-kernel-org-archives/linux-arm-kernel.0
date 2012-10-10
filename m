From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 10 Oct 2012 01:54:56 -0300
Subject: [PATCH] ARM: dts: imx28: add the `clock-names` for gpmi-nand
In-Reply-To: <1349837086-21844-1-git-send-email-b32955@freescale.com>
References: <1349837086-21844-1-git-send-email-b32955@freescale.com>
Message-ID: <CAOMZO5A0UX6y3MtHdzZ8V2Z52qsH8Yy-BVtOYEN_OpBezEsvQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Huang,

On Tue, Oct 9, 2012 at 11:44 PM, Huang Shijie <b32955@freescale.com> wrote:
> The current DT node misses the `clocks-names` item for gpmi-nand.
> So the gpmi-nand driver could not find the proper clock.
>
> This patch fixes this issue.
>
> Signed-off-by: Huang Shijie <b32955@freescale.com>

Thanks for the fix.

Could you please also fix mx23 in the same patch?

Regards,

Fabio Estevam
