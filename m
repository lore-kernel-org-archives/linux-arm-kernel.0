From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Apr 2011 12:55:33 -0300
Subject: [PATCH 5/9] ARM i.MX53 loco: Add framebuffer support
In-Reply-To: <1303738839-27659-1-git-send-email-weitway@gmail.com>
References: <1303738839-27659-1-git-send-email-weitway@gmail.com>
Message-ID: <BANLkTin7cE6-aO=yWOa5tVCeTudBMVvGaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2011 at 10:40 AM,  <weitway@gmail.com> wrote:
> From: Jason Chen <b02280@freescale.com>
>
> Signed-off-by: Jason Chen <Jason.Chen@freescale.com>
> Signed-off-by: Jason Chen <Jason.Chen@linaro.org>
> ---
> ?arch/arm/mach-mx5/Kconfig ? ? ? ? ? | ? ?1 +
> ?arch/arm/mach-mx5/board-mx53_loco.c | ? 23 +++++++++++++++++++++++
> ?arch/arm/mach-mx5/clock-mx51-mx53.c | ? ?9 ++++++---
> ?3 files changed, 30 insertions(+), 3 deletions(-)

Changes in clock-mx51-mx53.c should be part of a separate patch as it
is not MX53_Loco specific.

Regards,

Fabio Estevam
