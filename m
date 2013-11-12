From: sre@ring0.de (Sebastian Reichel)
Date: Tue, 12 Nov 2013 16:30:57 +0100
Subject: [PATCH 4/5 v2] input: tc3589x-keypad: support probing from
 device tree
In-Reply-To: <1384265618-10590-1-git-send-email-linus.walleij@linaro.org>
References: <1384265618-10590-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131112153057.GA9683@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Nov 12, 2013 at 03:13:38PM +0100, Linus Walleij wrote:
> +	plat->no_autorepeat = of_property_read_bool(np, "linux,no-autorepeat");
> +	plat->enable_wakeup = of_property_read_bool(np, "linux,wakeup");

There is currently discussion going on for the property name of
autorepeat:

https://lkml.org/lkml/2013/11/11/680

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131112/16bff385/attachment.sig>
