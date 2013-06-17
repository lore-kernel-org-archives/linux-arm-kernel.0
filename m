From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 18:53:33 +0200
Subject: [PATCH] ARM: ux500: add restart support via prcmu
In-Reply-To: <1371216160-2595-1-git-send-email-fabio.baltieri@linaro.org>
References: <1371216160-2595-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkdbkXUkq5VBq8QEf11r=ByqmeyNcxMHkfVs8ip=_O5G4CA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 3:22 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> Add necessary code to restart ux500 based machines using
> prcmu_system_reset().
>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> ---
>
> Hi Linus,
>
> this is something I had in my tree for some time.  This adds basic
> soft-reboot support for all ux500 machines using prcmu (the actual
> reboot code was already there) and may also be useful as a base to add
> the remaining "reboot reason" code if necessary.
>
> This is based on your current ste-next branch.

Patch applied.

If you're meriging "reboot reason" code, rename "reason" to
"cause" everywhere. Cause and effect. Causality. Not the
age of reason.

Yours,
Linus Walleij
