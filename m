From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 26 Nov 2012 20:19:03 +0100
Subject: [PATCH 9/9] ARM: remove mach .handle_irq for VIC users
In-Reply-To: <1353466713-18967-10-git-send-email-robherring2@gmail.com>
References: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
 <1353466713-18967-10-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdZ__KgBWQAC17rMQ3eABt-A9=U7GDirYi7xQKAqbmOZ6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 21, 2012 at 3:58 AM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <rob.herring@calxeda.com>
>
> Now that the VIC initialization sets up the handle_arch_irq pointer, we
> can remove it for all machines and make it static.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
