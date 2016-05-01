From: manabian@gmail.com (Joachim Eastwood)
Date: Sun, 1 May 2016 23:04:33 +0200
Subject: [PATCH 3/7] reset: lpc18xx: use devm_reset_controller_register()
In-Reply-To: <1462099023-11819-4-git-send-email-yamada.masahiro@socionext.com>
References: <1462099023-11819-1-git-send-email-yamada.masahiro@socionext.com>
 <1462099023-11819-4-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAGhQ9Vy-Cux5G0EsVv_eU9a97x5qr7T17GKSxGOKgf5JABeEZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 May 2016 at 12:36, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> Use devm_reset_controller_register() for the reset controller
> registration and remove the unregister call from the .remove callback.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Acked-by: Joachim Eastwood <manabian@gmail.com>


regards,
Joachim Eastwood
