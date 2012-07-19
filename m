From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Jul 2012 14:23:28 +0000
Subject: [PATCH 1/2] ARM: vt8500: Update vt8500-ehci driver to support
 device tree.
In-Reply-To: <1342704684-4858-1-git-send-email-linux@prisktech.co.nz>
References: <1342704684-4858-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <201207191423.28673.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 19 July 2012, Tony Prisk wrote:
> 
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  drivers/usb/host/ehci-vt8500.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

The addition is straightforward and looks correct, but I would suggest you
also add the new "compatible" values to
Documentation/devicetree/bindings/usb-ehci.txt

	Arnd
