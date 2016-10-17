From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 17 Oct 2016 15:48:49 +0200
Subject: [PATCH 1/3] arm: hisi: add ARCH_MULTI_V5 support
In-Reply-To: <20161017120705.3726-2-wenpan@hisilicon.com>
References: <20161017120705.3726-1-wenpan@hisilicon.com>
 <20161017120705.3726-2-wenpan@hisilicon.com>
Message-ID: <5893354.6MrIxqzRoI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, October 17, 2016 8:07:03 PM CEST Pan Wen wrote:
> Add support for some HiSilicon SoCs which depend on ARCH_MULTI_V5.
> 
> Signed-off-by: Pan Wen <wenpan@hisilicon.com>
> 

Looks ok. I've added Marty Plummer to Cc, he was recently proposing
patches for Hi3520, which I think is closely related to this one.
Please try to work together so the patches don't conflict. It should
be fairly straightforward since you are basically doing the same
change here.

	Arnd
