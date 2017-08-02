From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Aug 2017 13:51:47 +0200
Subject: [PATCH] pinctrl: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-43-robh@kernel.org>
References: <20170718214339.7774-43-robh@kernel.org>
Message-ID: <CACRpkdauP1T9bpp8C68wt6oK7gosAHt3pR7i=2+zRvPwXHo3ZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 11:43 PM, Rob Herring <robh@kernel.org> wrote:

> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Barry Song <baohua@kernel.org>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: kernel at stlinux.com
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-renesas-soc at vger.kernel.org

Patch applied with the recieved ACKs.

Yours,
Linus Walleij
