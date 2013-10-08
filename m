From: marex@denx.de (Marek Vasut)
Date: Tue, 8 Oct 2013 22:58:57 +0200
Subject: [PATCH 3/9] i2c: i2c-mxs: replace platform_driver_probe to
 support deferred probing
In-Reply-To: <1381264542-29396-4-git-send-email-wsa@the-dreams.de>
References: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
 <1381264542-29396-4-git-send-email-wsa@the-dreams.de>
Message-ID: <201310082258.57659.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> Subsystems like pinctrl and gpio rightfully make use of deferred probing at
> core level. Now, deferred drivers won't be retried if they don't have a
> .probe function specified in the driver struct. Fix this driver to have
> that, so the devices it supports won't get lost in a deferred probe.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> Cc: Marek Vasut <marex@denx.de>

Certainly makes sense,

Acked-by: Marek Vasut <marex@denx.de>

Thanks!

Best regards,
Marek Vasut
