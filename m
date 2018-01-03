From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 3 Jan 2018 09:03:41 +0100
Subject: [PATCH 05/12] pinctrl: armada-37xx: account for const type of
 of_device_id.data
In-Reply-To: <1514899688-27844-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
 <1514899688-27844-6-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <CACRpkdZhQKtrRgGu17OkDca3XR1tOSj00hDABfv6JKTUDh2xBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 2, 2018 at 2:28 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:

> The data field of an of_device_id structure has type const void *, so
> there is no need for a const-discarding cast when putting const values
> into such a structure.
>
> Done using Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Patch applied with Gregory's ACK.

Yours,
Linus Walleij
