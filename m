From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Oct 2015 14:57:36 -0300
Subject: [PATCH 03/12] gpu: imx: simplify sync polarity setting
In-Reply-To: <E1ZO6at-0002qb-2m@rmk-PC.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
 <E1ZO6at-0002qb-2m@rmk-PC.arm.linux.org.uk>
Message-ID: <CAOMZO5CEVoA3BRUoiUCUWnTRV7655w4OEVuKXGWA+VvCusYqMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 8, 2015 at 1:03 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Use a function to convert the sync pin to a bit mask for the DI_GENERAL
> register, and move this out of the interlace/non-interlace path to the
> common path.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
