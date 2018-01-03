From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Jan 2018 08:58:24 +0100
Subject: [PATCH 02/12] pinctrl: at91-pio4: account for const type of
 of_device_id.data
In-Reply-To: <1514899688-27844-3-git-send-email-Julia.Lawall@lip6.fr>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
 <1514899688-27844-3-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CACRpkdZD6x4NZbbUBSZDOtFGS=Rg21ewup3-Gr9n3e1fosA0cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 2, 2018 at 2:27 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> This driver creates a const structure that it stores in the data field
> of an of_device_id array.
>
> Adding const to the declaration of the location that receives the
> const value from the data field ensures that the compiler will
> continue to check that the value is not modified.  Furthermore, the
> const-discarding cast on the extraction from the data field is no
> longer needed.
>
> Done using Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Patch applied.

Yours,
Linus Walleij
