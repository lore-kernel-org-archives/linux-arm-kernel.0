From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 10 Dec 2012 23:13:03 +0900
Subject: [PATCH 04/12] regulator: gpio-regulator: gpio_set_value should
 use cansleep
In-Reply-To: <1355129761-8088-5-git-send-email-lee.jones@linaro.org>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
 <1355129761-8088-5-git-send-email-lee.jones@linaro.org>
Message-ID: <20121210141302.GE6103@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 08:55:53AM +0000, Lee Jones wrote:
> If it's possible for gpio_set_value to sleep, we should be using
> the *_cansleep call instead. This patch fixes multiple warnings
> from gpiolib.

Applied, thanks.
