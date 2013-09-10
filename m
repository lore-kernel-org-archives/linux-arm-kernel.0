From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 10 Sep 2013 16:19:13 +0200
Subject: [PATCH 4/7] ptp: switch to use gpiolib
In-Reply-To: <1378816260-8091-1-git-send-email-linus.walleij@linaro.org>
References: <1378816260-8091-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130910141912.GB5088@netboy>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 10, 2013 at 02:31:00PM +0200, Linus Walleij wrote:
> This platform supports gpiolib, so remove the custom API use
> and replace with calls to gpiolib. Also request the GPIO before
> starting to use it.
> 
> Cc: Imre Kaloz <kaloz@openwrt.org>
> Cc: Krzysztof Halasa <khc@pm.waw.pl>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Richard Cochran <richardcochran@gmail.com>
> Cc: netdev at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Hi Richard, I'm seeking an ACK on this patch to take it throug
> the GPIO tree as part of a clean-out of custom GPIO implementations.

I don't have this hardware for testing (it is really obsolete now),
but the change looks okay to me.

Acked-by: Richard Cochran <richardcochran@gmail.com>
