From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Oct 2014 16:49:43 +0200
Subject: [GIT PULL] ARM: dts: Keystone DTS fixes updates for 3.18
In-Reply-To: <1412174054-25042-1-git-send-email-santosh.shilimkar@ti.com>
References: <1412174054-25042-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <10608387.uhvzSybtM3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 October 2014 10:34:14 Santosh Shilimkar wrote:
> Few keystone DTS fixes for 3.18
> 
>         - IO range fix for USB phy device
>         - Add missing dma-coherent property for K2E USB node
>         - Fix K2L MDIO start address
>         - Fix K2E MDIO start address

Pulled into next/dt. I've stopped taking non-bugfix patches for 3.18,
but these all look like we need them.

	Arnd
