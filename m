From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 Aug 2017 13:55:56 +0200
Subject: [PATCH 1/3] of/pci: Add dma-ranges parsing support
In-Reply-To: <0d4313c7-6595-a7fb-680a-e231dc9c0902@sigmadesigns.com>
References: <f10055cc-4430-ff30-f892-3d3d6f24354c@sigmadesigns.com>
 <0d4313c7-6595-a7fb-680a-e231dc9c0902@sigmadesigns.com>
Message-ID: <CACRpkdZ-6dAJ2b+h0x0Shcfr8hsgp-xPa9vnPgm27gYt8Otk4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 29, 2017 at 4:25 PM, Marc Gonzalez
<marc_gonzalez@sigmadesigns.com> wrote:

> Several host bridge drivers duplicate of_pci_range_parser_init()
> in order to parse their dma-ranges property.
>
> Provide of_pci_dma_range_parser_init() for that use-case.
>
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>

Looks good to me.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
