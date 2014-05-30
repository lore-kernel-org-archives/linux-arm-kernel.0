From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 30 May 2014 11:48:22 +0200
Subject: [PATCH v2 05/11] ARM: versatile: remove init_irq hook for DT boot
In-Reply-To: <1401403221-27523-6-git-send-email-robherring2@gmail.com>
References: <1401403221-27523-1-git-send-email-robherring2@gmail.com>
 <1401403221-27523-6-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkdbbgxS=q=3oVUZoatNCGXumbiY3Y8CAfYbDZ1ALrP0zaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 30, 2014 at 12:40 AM, Rob Herring <robherring2@gmail.com> wrote:

> From: Rob Herring <robh@kernel.org>
>
> Now that versatile's irqchips are initialized from DT, the init_irq hook
> can be removed.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
