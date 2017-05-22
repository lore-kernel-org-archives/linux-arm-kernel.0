From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 May 2017 17:13:40 +0200
Subject: [PATCH] gpio: zynq: remove unneeded (void *) casts in
 of_match_table
In-Reply-To: <1494605925-6487-1-git-send-email-yamada.masahiro@socionext.com>
References: <1494605925-6487-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CACRpkdbFn-_2PpZr-CLKfswQny+CgLKrN_HLVUQN7U3D8_mMRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 12, 2017 at 6:18 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:

> of_device_id::data is an opaque pointer.  No explicit cast is needed.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Patch applied with S?ren's ACK.

Yours,
Linus Walleij
