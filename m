From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 10 Dec 2012 23:12:52 +0900
Subject: [PATCH 03/12] regulator: gpio-regulator: Fix logical error in
 for() loop
In-Reply-To: <1355129761-8088-4-git-send-email-lee.jones@linaro.org>
References: <1355129761-8088-1-git-send-email-lee.jones@linaro.org>
 <1355129761-8088-4-git-send-email-lee.jones@linaro.org>
Message-ID: <20121210141251.GD6103@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 10, 2012 at 08:55:52AM +0000, Lee Jones wrote:
> The cond-statement of this particular for() loop will always be
> true as long as at least one voltage-shifting GPIO is present.
> If it wasn't for the break below, we'd be stuck in a forever loop.
> This patch inserts the correct cond-statement into the statement.

Applied, thanks.
