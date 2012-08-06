From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 6 Aug 2012 13:17:56 +0200
Subject: [PATCH 6/6] Input: ab8500-ponkey: Make the distinction between DT
 and non-DT boots
In-Reply-To: <1344250002-6011-7-git-send-email-lee.jones@linaro.org>
References: <1344250002-6011-1-git-send-email-lee.jones@linaro.org>
 <1344250002-6011-7-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdZmZtQJ_tqp8=cC2NbRvNosN8rDwfwDxocw=a=WtH0sZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 6, 2012 at 12:46 PM, Lee Jones <lee.jones@linaro.org> wrote:

> If we're booting with Device Tree enabled, we want the IRQ numbers to
> be taken and translated from the Device Tree binary. If not, they
> should be taken from the resource allocation defined in the AB8500 MFD
> core driver.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Aha that's the missing patch.
Tested-by: Linus Walleij <linus.walleij@linaro.org>

This one should be split off from the patch series and sent as a separate
fix to Dmitry as it badly needs to go into the -rc series through the input
tree.

Can't see what it is doing as part of this series, it has no relation to the
other patches.

Dmitry, you can replace my revert with this patch as soon as Lee send
it to linux-input.

Yours,
Linus Walleij
