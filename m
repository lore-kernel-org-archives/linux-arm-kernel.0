From: robh+dt@kernel.org (Rob Herring)
Date: Fri, 1 Sep 2017 13:27:13 -0500
Subject: [PATCH 1/3] of/pci: Add dma-ranges parsing support
In-Reply-To: <0d4313c7-6595-a7fb-680a-e231dc9c0902@sigmadesigns.com>
References: <f10055cc-4430-ff30-f892-3d3d6f24354c@sigmadesigns.com>
 <0d4313c7-6595-a7fb-680a-e231dc9c0902@sigmadesigns.com>
Message-ID: <CAL_JsqJjNMKLk56CB2i57URYB_9wjuO4opod9xXztmr+MaJnvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 29, 2017 at 9:25 AM, Marc Gonzalez
<marc_gonzalez@sigmadesigns.com> wrote:
> Several host bridge drivers duplicate of_pci_range_parser_init()
> in order to parse their dma-ranges property.
>
> Provide of_pci_dma_range_parser_init() for that use-case.
>
> Signed-off-by: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> ---
>  drivers/of/address.c       | 19 ++++++++++++++++---
>  include/linux/of_address.h | 10 +++++++++-
>  2 files changed, 25 insertions(+), 4 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>

I'm assuming this will go thru the PCI tree.

Rob
