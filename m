From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 Oct 2013 11:18:24 +0200
Subject: [PATCH] sh-pfc: r8a7791 PFC support
In-Reply-To: <20131008040824.3480.69707.sendpatchset@w520>
References: <20131008040824.3480.69707.sendpatchset@w520>
Message-ID: <CACRpkdaJGXAW4B3G4qbByvRc7fWjjYynPwk=T_52eFGCQYq_Sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 8, 2013 at 6:08 AM, Magnus Damm <magnus.damm@gmail.com> wrote:

> From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
>
> Add PFC support for the r8a7791 SoC including pin groups for
> on-chip devices such as MSIOF, SCIF, USB, MMC, VIN, SDHI, DU.
>
> Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> Signed-off-by: Kunihito Higashiyama <kunihito.higashiyama.ur@renesas.com>
> Signed-off-by: Yoshikazu Fujikawa <yoshikazu.fujikawa.ue@renesas.com>
> Signed-off-by: Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>
> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> [damm at opensource.se: Forward ported to upstream, reused existing sh-pfc macros]
> Signed-off-by: Magnus Damm <damm@opensource.se>

Need Laurent to look at this, he also queues PCF patches nowadays,
it was a lot of data but I guess life is like that in this controller...

Yours,
Linus Walleij
