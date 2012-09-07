From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 7 Sep 2012 23:17:10 +0200
Subject: [PATCH v2 0/6] Make mach/gpio.h optional
In-Reply-To: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
References: <1346960563-18689-1-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkda3dzsaN_nrHjfNjuz=-0z73ZWXgAWysXQY11jXgSP-+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 6, 2012 at 9:42 PM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
>
> This is series makes mach/gpio.h optional like we have done for other
> mach headers in preparation for multi-platform kernel images.

I like this approach. It's in the spirit of some similar stuff I made
a year ago or two.
Acked-by: Linus Walleij <linus.walleij@linaro.org>

For all of U300, Nomadik, Ux500, and as GPIO second man.

Yours,
Linus Walleij
