From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 28 Mar 2016 17:13:42 -0300
Subject: [PATCH] i.MX6 PCIe: Fix imx6_pcie_deassert_core_reset() polarity
In-Reply-To: <CAJ+vNU2Sg1ZKBsGcQswrJZyTJ1WBEZor3ZqpoYUT7i9FKjEAog@mail.gmail.com>
References: <m3h9fuk7ik.fsf@t19.piap.pl>
 <CAOMZO5DcZCxoLPeGRWSGkstm7F3eN-Q-yJyf6ktMTda2zLviag@mail.gmail.com>
 <CAOMZO5B8Lzn-E4YOeYxVtN5PN11aOvZHn4eU0ixkdV8CO8+xYw@mail.gmail.com>
 <CAJ+vNU2Sg1ZKBsGcQswrJZyTJ1WBEZor3ZqpoYUT7i9FKjEAog@mail.gmail.com>
Message-ID: <CAOMZO5DO9G18=_YSri3a+UiYbLwN6AMG4asUXbT03mpbU3hHrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

On Mon, Mar 28, 2016 at 4:59 PM, Tim Harvey <tharvey@gateworks.com> wrote:

> Fabio,
>
> I would agree with you on this - 5c5fb40de8f143 ("PCI: imx6: Add
> support for active-low reset GPIO")  should be reverted.
>
> I just finished bisecting an issue to this specific patch only to find
> out Krzysztof found it a few days ago ;) Thanks Krzysztof.

I sent the revert patch yesterday:
http://marc.info/?l=linux-pci&m=145912622805757&w=2
