From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Apr 2013 22:52:30 +0200
Subject: [PATCH v2 2/2] ARM: ux500: 8500: add ab8500-musb pinctrl support
In-Reply-To: <1364560187-20495-1-git-send-email-fabio.baltieri@linaro.org>
References: <1364487669-24368-3-git-send-email-fabio.baltieri@linaro.org>
 <1364560187-20495-1-git-send-email-fabio.baltieri@linaro.org>
Message-ID: <CACRpkdZY211JisP=GNp9CLY11X9UxZcTBNu7PZNZxZyM0sn5Vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 29, 2013 at 1:29 PM, Fabio Baltieri
<fabio.baltieri@linaro.org> wrote:

> From: Patrice Chotard <patrice.chotard@stericsson.com>
>
> Add necessary definitions to support ab8500-musb pinctrl default and
> sleep states.
>
> Signed-off-by: Patrice Chotard <patrice.chotard@stericsson.com>
> Signed-off-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> ---
>
> Hi Linus,
>
> I'm sending a v2 on this one as I mis-replaced a device id (manually
> applied patch, sorry about that).
>
> Changes from v1:
> - fix typo in GPIO257_AE29 device name

Thanks, patch applied!

Yours,
Linus Walleij
