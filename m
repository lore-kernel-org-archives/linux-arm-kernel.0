From: zonque@gmail.com (Daniel Mack)
Date: Sat, 18 Jun 2011 22:56:11 +0200
Subject: irq flood with mmc boot partitions on s3c2416 with 3.0rc1
In-Reply-To: <201106022149.47936.heiko@sntech.de>
References: <201106022149.47936.heiko@sntech.de>
Message-ID: <BANLkTinCyr=pL9tyK+F9XxX2r15acqEsNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 2, 2011 at 9:49 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Hi,
>
> after upgrading my development kernel from 2.6.38 to 3.0rc1 I get flooded (i.e.
> it never stops) by messages of the form:

Even though it's not really related to SDIO, does reverting 06e8935
("mmc: sdio: optimized SDIO IRQ handling for single irq") fix your
problem?

Daniel
