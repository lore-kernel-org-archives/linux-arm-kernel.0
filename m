From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Oct 2017 13:42:58 +0100
Subject: [GIT PULL] Mediatek: 32-bit DT update for v4.15
In-Reply-To: <c7145c00-b2b9-780c-0bfd-15f7d8a08dd6@gmail.com>
References: <c7145c00-b2b9-780c-0bfd-15f7d8a08dd6@gmail.com>
Message-ID: <CAK8P3a3NWwoe0mX45WrFONyiHt9eWTTMziEc+rjqSfr5QZv8xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 23, 2017 at 12:06 AM, Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
> ----------------------------------------------------------------
> - mt76233 add PCIe node

Could you clarify what the subnodes in the PCI node are for? It seems odd
to have "interrupt-map" properties in both the pcie controller and its child
nodes, and I want to ensure this is following the standard PCIe binding before
I pull it.

       Arnd
