From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Apr 2013 13:36:26 +0200
Subject: [PATCHv7 00/17] PCIe support for the Armada 370 and Armada XP SoCs
In-Reply-To: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1364395234-11195-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACRpkdb77h+7FCjEbc3Jy9+3M5KdCEk3ktsuTHOT1W6AKToJZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 27, 2013 at 3:40 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> As we are approaching 3.10, I would now like to get formal Acked-by,
> or disagreements from the following maintainers/developers :
>
>  * Grant Likely, as the OF maintainer, for patches 1, 2 and 3
>
>    [PATCH v5 01/17] of/pci: Provide support for parsing PCI DT ranges
>    [PATCH v5 02/17] of/pci: Add of_pci_get_devfn() function
>    [PATCH v5 03/17] of/pci: Add of_pci_parse_bus_range() function

I think Rob Herring can help out in reviewing this, as comaintainer
of devicetree stuff.

Yours,
Linus Walleij
