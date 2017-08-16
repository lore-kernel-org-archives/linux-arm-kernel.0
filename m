From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Tue, 15 Aug 2017 23:08:47 -0700
Subject: [PATCH] gpio: brcmstb: check return value of
 gpiochip_irqchip_add()
In-Reply-To: <1502319087-23396-1-git-send-email-yamada.masahiro@socionext.com>
References: <1502319087-23396-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CADtm3G70RM_gomboAovi8_=qjj-FqN4PTFAo_tPKCApg5somEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 9, 2017 at 3:51 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Because gpiochip_irqchip_add() may fail, its return value should
> be checked.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
