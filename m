From: olof@lixom.net (Olof Johansson)
Date: Thu, 27 Oct 2016 17:00:06 -0700
Subject: [PATCH] ARM: defconfig: update U8500 defconfig
In-Reply-To: <1476696229-1964-1-git-send-email-linus.walleij@linaro.org>
References: <1476696229-1964-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20161028000006.GA7284@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 17, 2016 at 11:23:49AM +0200, Linus Walleij wrote:
> Some config options like perf events and PM are now implicit,
> we have an upstream driver for the AK8974, and we really
> want the HRTIMER software triggers from configfs with some
> of the sensors.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this wherever your usual batch of
> defconfig changes go.

Thanks, applied!


-Olof
