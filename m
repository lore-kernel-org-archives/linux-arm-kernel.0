From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 8 Jan 2015 21:47:36 +0100 (CET)
Subject: [PATCH RFC V3 2/3] mxs: add driver for ocotp in i.MX23 and i.MX28
In-Reply-To: <54AE8D45.7050805@imgtec.com>
References: <1413628372-2809-1-git-send-email-stefan.wahren@i2se.com>
 <2223659.OW08fe0cS1@wuerfel>
 <1003885907.22061.1415301932743.JavaMail.open-xchange@oxbsltgw00.schlund.de>
 <6087001.lBonPVHV5K@wuerfel> <54AE8D45.7050805@imgtec.com>
Message-ID: <206462161.1173993.1420750056099.JavaMail.open-xchange@oxbaltgw07.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ezequiel,

> Ezequiel Garcia <ezequiel.garcia@imgtec.com> hat am 8. Januar 2015 um 14:59
> geschrieben:
>
>
> Hi Stefan, Arnd,
>
> (I'm trimming the Cc list and adding Thierry and Maxime to the loop):
>
> [...]
>
> I've talked to Arnd on IRC and we agreed to create a new directory
> drivers/efuse. As a first step we would just move the tegra driver,
> and add the new drivers (img on my side, and possibly mxs on Stefan's).
> Perhaps we would also pull the sunxi_sid driver as well.

AFAIK the binding documentation for the tegra driver is stored in

Documentation/devicetree/bindings/fuse/

so a consistent naming would be better. Beside that i'm okay with the approach.

Stefan
