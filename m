From: balbi@ti.com (Felipe Balbi)
Date: Mon, 10 Oct 2011 09:10:29 +0300
Subject: [PATCH 15/30] usb/musb: use a Kconfig choice to pick the right
	DMA method
In-Reply-To: <1317566760-25681-16-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-16-git-send-email-arnd@arndb.de>
Message-ID: <20111010061026.GF31707@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 04:45:45PM +0200, Arnd Bergmann wrote:
> The logic to allow only one DMA driver in MUSB is currently
> flawed, because it also allows picking no DMA driver at all
> and also not selecting PIO mode.
> 
> Using a choice statement makes this foolproof for now and
> also simplifies the Makefile.
> 
> Unfortunately, we will have to revisit this when we start
> supporting multiple ARM platforms in a single kernel binary,
> because at that point we will actually need to select
> multiple DMA drivers and pick the right one at run-time.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Felipe Balbi <balbi@ti.com>

applied, thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111010/6dbad263/attachment-0001.sig>
