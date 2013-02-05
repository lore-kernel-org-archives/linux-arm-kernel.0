From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 5 Feb 2013 19:02:29 +0100
Subject: [PATCH 9/9] gpiolib: dynamically allocate descriptors array
In-Reply-To: <1359822572-26009-11-git-send-email-acourbot@nvidia.com>
References: <1359822572-26009-1-git-send-email-acourbot@nvidia.com>
 <1359822572-26009-11-git-send-email-acourbot@nvidia.com>
Message-ID: <CACRpkdaTF1Ca5GX-D+cx-_LrOVZyhX_mgLGRfv65dabof5-RYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 2, 2013 at 5:29 PM, Alexandre Courbot <acourbot@nvidia.com> wrote:

> Allocate the GPIO descriptor's memory dynamically when GPIO chips are
> added instead of using the static gpio_desc[] array. gpio_desc[] is now
> totally unused and therefore removed.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
