From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 21 Nov 2012 11:03:00 +0100
Subject: [PATCH 364/493] pinctrl: remove use of __devinitconst
In-Reply-To: <1353349642-3677-364-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-364-git-send-email-wfp5p@virginia.edu>
Message-ID: <CACRpkdbBZP8t2RRTmX5Rwokqgkb7ajXmgcRTSoxhXcABbMw4Sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 7:25 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:

> CONFIG_HOTPLUG is going away as an option so __devinitconst is no
> longer needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Barry Song <baohua.song@csr.com>
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
