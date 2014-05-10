From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 10 May 2014 12:06:52 -0400
Subject: [PATCH v11 1/6] ARM: sunxi: Add driver for SD/MMC hosts found on
 Allwinner sunxi SoCs
In-Reply-To: <1399714443-12459-2-git-send-email-hdegoede@redhat.com>
References: <1399714443-12459-1-git-send-email-hdegoede@redhat.com>
 <1399714443-12459-2-git-send-email-hdegoede@redhat.com>
Message-ID: <20140510160652.GM7047@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 10, 2014 at 11:33:58AM +0200, Hans de Goede wrote:
> From: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> 
> The Allwinner sunxi mmc host uses dma in bus-master mode using a built-in
> designware idmac controller, which is identical to the one found in the mmc-dw
> hosts. However the rest of the host is not identical to mmc-dw, it deals with
> sending stop commands in hardware which makes it significantly different
> from the mmc-dw devices.
> 
> HdG: Various cleanups and fixes.
> 
> Signed-off-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Chris, I don't think we ever got a review from you on this? Do you
have any comments on this patch? It would be great if we could merge
it for 3.16.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140510/6f96bf33/attachment.sig>
