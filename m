From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 20 Nov 2012 23:44:59 +0100
Subject: [PATCH 312/493] mfd: remove use of __devinitdata
In-Reply-To: <1353349642-3677-312-git-send-email-wfp5p@virginia.edu>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu>
 <1353349642-3677-312-git-send-email-wfp5p@virginia.edu>
Message-ID: <CACRpkdbBtLR4BvtHXdpvSFLd9SEiS5RB2NVzoZye65z57EZ05w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 7:24 PM, Bill Pemberton <wfp5p@virginia.edu> wrote:

> CONFIG_HOTPLUG is going away as an option so __devinitdata is no
> longer needed.
>
> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Peter Tyser <ptyser@xes-inc.com>
> Cc: linux-arm-kernel at lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
