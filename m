From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 5 Sep 2018 11:09:21 +0200
Subject: [PATCH] ARM: u300: add missing check for kmalloc
In-Reply-To: <1535106534-983-1-git-send-email-hofrat@osadl.org>
References: <1535106534-983-1-git-send-email-hofrat@osadl.org>
Message-ID: <CACRpkdYdGeuFt7c+VJ=4bP+Ekgeq4_srRXD_+eQdkJcgBF6XmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 24, 2018 at 12:33 PM Nicholas Mc Guire <hofrat@osadl.org> wrote:

>  kmalloc return for bigrxbuf_virtual was not being checked - in case
> of failure set status, cleanup bigtxbuf_virtual and baile out.
>
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: c7c8c78fdf6e ("ARM: 5667/3: U300 SSP/SPI board setup and test")

I will delete this testchip instead. It is not in use.

Yours,
Linus Walleij
