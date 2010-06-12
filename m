From: eric.y.miao@gmail.com (Eric Miao)
Date: Sat, 12 Jun 2010 19:48:25 +0800
Subject: [PATCH 4/5] [ARM] usb/host/ohci-pxa27x: make PXA310 USB OTG port
	work in host mode.
In-Reply-To: <1275464450-23003-5-git-send-email-grinberg@compulab.co.il>
References: <1275464450-23003-1-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-2-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-3-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-4-git-send-email-grinberg@compulab.co.il>
	<1275464450-23003-5-git-send-email-grinberg@compulab.co.il>
Message-ID: <AANLkTilUt8D7B3UF_j1wOvsnXTVQyioofwMEikScdLOn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 2, 2010 at 3:40 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
> ?arch/arm/mach-pxa/include/mach/ohci.h ? ? | ? ?3 +
> ?arch/arm/mach-pxa/include/mach/regs-u2d.h | ? ?2 +
> ?drivers/usb/host/ohci-pxa27x.c ? ? ? ? ? ?| ?183 +++++++++++++++++++++++++++++

My feeling is on pxa310, the OTG/ULPI is actually closer to the UDC, so
generally, I'd really like to see minimum change to ohci.
