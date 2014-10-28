From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Oct 2014 10:58:57 +0100
Subject: [PATCH 4/8] power: ab8500: Use power_supply_*() API for accessing
 function attrs
In-Reply-To: <1413289246-31650-5-git-send-email-k.kozlowski@samsung.com>
References: <1413289246-31650-1-git-send-email-k.kozlowski@samsung.com>
 <1413289246-31650-5-git-send-email-k.kozlowski@samsung.com>
Message-ID: <CACRpkdbL8dn-GVvXU83u_Wx-VKCer-mc6pisZhtPXgBNMo4rtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 2:20 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:

> Replace direct calls to power supply function attributes with wrappers.
> Wrappers provide safe access access in case of unregistering the power
> supply (.e.g by removing the driver). Replace:
>  - get_property -> power_supply_get_property
>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
