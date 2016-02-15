From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 15 Feb 2016 06:01:18 +0100
Subject: [PATCH 2/2] ARM: versatile: move restart to the device tree
In-Reply-To: <1453710656-14280-1-git-send-email-linus.walleij@linaro.org>
References: <1453710656-14280-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160215050118.GC28626@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 25, 2016 at 09:30:56AM +0100, Linus Walleij wrote:
> We have a power/reset driver for the Versatile family
> in drivers/power/reset so let's just activate that driver
> and use it and get rid of some non-DT remnants.
> 
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-By: Sebastian Reichel <sre@kernel.org>

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160215/ac760a53/attachment.sig>
