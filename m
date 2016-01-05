From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 4 Jan 2016 21:19:44 -0600
Subject: [V5, 1/6] i2c: qup: Change qup_wait_writeready function to use
 for all timeouts
In-Reply-To: <1447760727-4897-2-git-send-email-sricharan@codeaurora.org>
References: <1447760727-4897-2-git-send-email-sricharan@codeaurora.org>
Message-ID: <20160105031944.GA4139@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 17, 2015 at 05:15:22PM +0530, Sricharan R wrote:
> qup_wait_writeready waits only on a output fifo empty event.
> Change the same function to accept the event and data length
> to wait as parameters. This way the same function can be used for
> timeouts in other places as well.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>

Looks good to me.

Reviewed-by: Andy Gross <andy.gross@linaro.org>
