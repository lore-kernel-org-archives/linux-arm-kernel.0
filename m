From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 31 Oct 2014 10:44:41 +0100
Subject: [PATCH RESEND V4 3/9] of: Update Tegra XUSB pad controller
 binding for USB
In-Reply-To: <1414535277-15645-4-git-send-email-abrestic@chromium.org>
References: <1414535277-15645-1-git-send-email-abrestic@chromium.org>
 <1414535277-15645-4-git-send-email-abrestic@chromium.org>
Message-ID: <CACRpkdbERA6rxrMTJQPGaNhAb=B3+KyQ1YBKNy2AqsLZD2eHDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 28, 2014 at 11:27 PM, Andrew Bresticker
<abrestic@chromium.org> wrote:

> Add new bindings used for USB support by the Tegra XUSB pad controller.
> This includes additional PHY types, USB-specific pinconfig properties, etc.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
> ---
> Changes from v2:
>  - Added nvidia,otg-hs-curr-level-offset property.
>  - Dropped "-otg" from VBUS supplies.
>  - Added mbox-names property.
>  - Removed extra whitespace.
> Changes from v1:
>  - Updated to use common mailbox bindings.
>  - Made USB3 port-to-lane mappins a top-level binding rather than a pinconfig
>    binding.
>  - Add #defines for the padctl lanes.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I guess you will take this patch along with the rest through ARM SoC
or so?

Yours.
Linus Walleij
