From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 15 Aug 2016 23:30:59 +0200
Subject: [RFC PATCH v5 3/3] net: phy: Add gmiitorgmii converter support
In-Reply-To: <1470735283-23611-4-git-send-email-appanad@xilinx.com>
References: <1470735283-23611-1-git-send-email-appanad@xilinx.com>
 <1470735283-23611-4-git-send-email-appanad@xilinx.com>
Message-ID: <20160815213059.GK24664@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> ---
> Thanks a lot Andrew for your inputs.
> Changes for v5:
> --> Fixed return values in the probe as suggested by punnaiah.
> --> Added a mask for the converter speed as suggested by punnaiah.
> +/* Xilinx GMII2RGMII Converter driver
> + *
> + * Copyright (C) 2016 Xilinx, Inc.
> + *
> + * Author: Kedareswara rao Appana <appanad@xilinx.com>

Not cool

https://github.com/lunn/linux/commit/03d375489ceb56e171056f44d0fe9c34ca5a098e

Notice the

Not-Signed-off-by: Andrew Lunn <andrew@lunn.ch>

and the Copyright i added?

In various emails i gave you the basic idea how this should be done, a
framework of code, and then took your code which did not even compile
and made the core of it work. This is as much my code as your code, so
i expect my Copyright to be kept on this code. And since this is my
code, i need to give a Signed-off-by, which i was not yet ready to
give since the code was not complete or working.

Please put both my Copyright back and Not-Signed-Off-by back and post
the next version as RFC. Once i'm happy this code is O.K, i will give
you a Signed-off-by.

    Andrew
