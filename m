From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Feb 2016 10:53:01 +0100
Subject: [PATCH 1/2] pinctrl: stm32: Remove dependency with DT bindings
 header files
In-Reply-To: <1454954259-4923-2-git-send-email-mcoquelin.stm32@gmail.com>
References: <1454954259-4923-1-git-send-email-mcoquelin.stm32@gmail.com>
 <1454954259-4923-2-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <CACRpkdb+V8O8H1gjkWwgqSimFtgJ2rFnwdY0sCChEjFSCkOO8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 8, 2016 at 6:57 PM, Maxime Coquelin
<mcoquelin.stm32@gmail.com> wrote:

> Some macros where defined in DT bindings headers, whereas only used
> in the driver.
>
> This patch moves these macros to the driver side.
>
> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>

Patch applied.

Yours,
Linus Walleij
