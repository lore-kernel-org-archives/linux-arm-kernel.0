From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 3 Oct 2018 15:28:11 +0200
Subject: [PATCH] PCI: armada8k: add support for gpio controlled reset
 signal
In-Reply-To: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
References: <405efb21a4600efad10413fcf4c72aacce180125.1538570983.git.baruch@tkos.co.il>
Message-ID: <20181003132811.GC427@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2018 at 03:49:43PM +0300, Baruch Siach wrote:
> This commit adds support for the gpio reset signal binding as described
> in the designware-pcie.txt DT binding document. Both the documented
> 'reset-gpio' property name, and the more standard 'reset-gpios' name are
> supported.

Hi Baruch

I don't know this code at all, so maybe a dumb question. Why support
the old none-standard binding of reset-gpio on new hardware? I'm
assuming reset-gpio is marked a deprecated and reset-gpios is
recommended?

    Andrew
