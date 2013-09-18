From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 18 Sep 2013 14:24:28 +0200
Subject: [PATCH 02/41] mfd: dbx500-prcmu: Move PRCMU numerical clock
 identifiers into DT include file
In-Reply-To: <1379506478-16625-3-git-send-email-lee.jones@linaro.org>
References: <1379506478-16625-1-git-send-email-lee.jones@linaro.org>
 <1379506478-16625-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CACRpkdYEByC3vBegbziibY2R63S3zSWxW=OOj0=TaeGP4igROQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 18, 2013 at 2:13 PM, Lee Jones <lee.jones@linaro.org> wrote:

> These are required to request DBx500 PRCMU clocks from Device Tree. The
> numbers used are taken directly from the Hardware Specification document.
> We're moving them from the DBx500 PRCMU include file into the DT include
> directory and referencing them from the former via a #include.
>
> Acked-by: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
