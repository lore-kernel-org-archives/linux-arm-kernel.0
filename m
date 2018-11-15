From: maxime.chevallier@bootlin.com (Maxime Chevallier)
Date: Thu, 15 Nov 2018 11:02:20 +0100
Subject: [RFC PATCH 0/6] Armada 38x comphy driver to support 2.5Gbps
 networking
In-Reply-To: <20181112122933.GD30658@n2100.armlinux.org.uk>
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
Message-ID: <20181115110220.77cff36d@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Mon, 12 Nov 2018 12:29:33 +0000
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

>Hi,
>
>This series adds support for dynamically switching between 1Gbps
>and 2.5Gbps networking for the Marvell Armada 38x SoCs, tested on
>Armada 388 on the Clearfog platform.

I've performed some tests on my side on a Clearfog too, and also on an
Armada 385 board. It works fine on both setups.

Thanks for implementing this,

Maxime
