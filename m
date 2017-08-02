From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 2 Aug 2017 11:24:22 +0200
Subject: [PATCH v2 2/2] ARM: dts: keystone-k2g-evm: Add gpio nodes
In-Reply-To: <1501048228-3492-2-git-send-email-j-keerthy@ti.com>
References: <1501048228-3492-1-git-send-email-j-keerthy@ti.com>
 <1501048228-3492-2-git-send-email-j-keerthy@ti.com>
Message-ID: <CACRpkdYvCngFxvK6kxA5rH9C8S37Eb8LSafnXks0caAzsq+Ejg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 7:50 AM, Keerthy <j-keerthy@ti.com> wrote:

> 66AK2G has 2 instances of gpio. The first one has all the 144 GPIOs
> functional( 9 banks with 16 gpios = 144). The second instance has
> only the GPIO0:GPIO67 functional and rest are marked reserved.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Merge this through the ARM SoC tree.

Yours,
Linus Walleij
