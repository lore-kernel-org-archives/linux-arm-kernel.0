From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Feb 2012 20:59:23 +0100
Subject: [PATCH] ux500: Remove keyboard pin definition for snowball
In-Reply-To: <1329216456-5569-1-git-send-email-philippe.langlais@stericsson.com>
References: <1329216456-5569-1-git-send-email-philippe.langlais@stericsson.com>
Message-ID: <CACRpkdZcer6Mvon7jmUbOWmg0Zwn2kjei=qni6b+E1J3EcQecw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 14, 2012 at 11:47 AM, Philippe Langlais
<philippe.langlais@stericsson.com> wrote:

> From: Philippe Langlais <philippe.langlais@linaro.org>
>
> Interfered with CG2900
>
> Signed-off-by: Benn P?rscke <benn.porscke@stericsson.com>
> Signed-off-by: Philippe Langlais <philippe.langlais@linaro.org>
> ---
> ?arch/arm/mach-ux500/board-mop500-pins.c | ? ?7 ++++++-
> ?1 files changed, 6 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
> index f8e7cd7..da17111 100644
> --- a/arch/arm/mach-ux500/board-mop500-pins.c
> +++ b/arch/arm/mach-ux500/board-mop500-pins.c
> @@ -419,7 +419,6 @@ static struct ux500_pin_lookup mop500_pins[] = {
> ? ? ? ?PIN_LOOKUP("nmk-i2c.1", &mop500_pins_i2c1),
> ? ? ? ?PIN_LOOKUP("nmk-i2c.2", &mop500_pins_i2c2),
> ? ? ? ?PIN_LOOKUP("nmk-i2c.3", &mop500_pins_i2c3),
> - ? ? ? PIN_LOOKUP("ske", &mop500_pins_ske),
> ? ? ? ?PIN_LOOKUP("sdi0", &mop500_pins_sdi0),
> ? ? ? ?PIN_LOOKUP("sdi1", &mop500_pins_sdi1),
> ? ? ? ?PIN_LOOKUP("sdi2", &mop500_pins_sdi2),

I cannot apply this patch, the "PIN_LOOKUP()" stuff is not in the
mainline kernel and needs submitting first/instead...

Yours,
Linus Walleij
