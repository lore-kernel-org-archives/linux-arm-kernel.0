From: lznuaa@gmail.com (Frank Li)
Date: Wed, 23 Jan 2013 15:44:53 +0800
Subject: [PATCH 1/2 net-next] net: fec: add napi support to improve
 proformance
In-Reply-To: <20130123072635.GO1906@pengutronix.de>
References: <1358914330-3768-1-git-send-email-Frank.Li@freescale.com>
 <20130123072635.GO1906@pengutronix.de>
Message-ID: <CAHrpEqQ3-prqJaCmt1hfOr4GzDVyuRNvko1SCyQZHdALhHkhkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This comment seems rather unnecessary. Also it should be
>
>         /* space left and right /*
>
> devicetree bindings should use '-' instead of '_'. The binding
> Documentation should be in the patch adding the bindings. Also
> make sure the devicetree parsing is outside of the path for platform
> based probing.
>
> With this particular binding I'm unsure it should exist anyway since
> it's configuration rather than hardware description. The devicetree
> normally is for hardware description only.
>

What's your opinion?
Using module parameter, device-tree to config it or the other method?

best regards
Frank Li
