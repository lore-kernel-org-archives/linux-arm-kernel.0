From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 3 Feb 2015 14:23:57 +0100
Subject: [PATCH 3/3] dts: versatile: add sysregs node
In-Reply-To: <1422467792-2065-4-git-send-email-robh@kernel.org>
References: <1422467792-2065-1-git-send-email-robh@kernel.org>
 <1422467792-2065-4-git-send-email-robh@kernel.org>
Message-ID: <CACRpkdaJ7Etuk0BGYuC0JwHR5Xp73dn96kOgDwM4+8+5EZ0jaA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 28, 2015 at 6:56 PM, Rob Herring <robh@kernel.org> wrote:

> The Versatile boards have the same sysregs as other ARM Ltd boards. Add
> the nodes in order to enable support for 24MHz counter as sched_clock.
>
> This is a minimal node definition as the existing sub node definition
> used on VExpress has some issues raised by Linus W.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: devicetree at vger.kernel.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
