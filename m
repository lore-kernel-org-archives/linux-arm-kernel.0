From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Sep 2016 22:41:03 +0200
Subject: [PATCH 2/3] pinctrl: nsp: constify pinctrl_ops and pinmux_ops
 structures
In-Reply-To: <1472755341-9995-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1472755341-9995-1-git-send-email-Julia.Lawall@lip6.fr>
 <1472755341-9995-3-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CACRpkdZSE=o_qSuBUkTA3FOpunaf7maNsue07L7ZGHyzc4xgMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 1, 2016 at 8:42 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> Check for pinctrl_ops and pinmux_ops structures that are only stored in the
> pctlops field and the pmxops field, respectively, of a pinctrl_desc
> structure.  These fields are declared const, so pinctrl_ops and pinmux_ops
> structures that have this property can be declared as const also.

Patch applied.

Yours,
Linus Walleij
