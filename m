From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 14 May 2013 10:25:15 +0200
Subject: [PATCH 3/9] clk: ux500: Provide device enumeration number suffix
 for SMSC911x
In-Reply-To: <1368019749-19455-4-git-send-email-lee.jones@linaro.org>
References: <1368019749-19455-1-git-send-email-lee.jones@linaro.org>
 <1368019749-19455-4-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdaWaEct1My5=gZ7Bbbizqsr3BBNSXiahMn3bS7L-SubLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 8, 2013 at 3:29 PM, Lee Jones <lee.jones@linaro.org> wrote:

> First Ethernet device has a ".0" appended onto the device name. It
> appears that we need this in order to obtain the correct clock.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Mike Turquette <mturquette@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
