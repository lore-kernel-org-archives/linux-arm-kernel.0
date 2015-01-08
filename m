From: balbi@ti.com (Felipe Balbi)
Date: Thu, 8 Jan 2015 10:58:34 -0600
Subject: [PATCH v2 2/3] usb: phy: add lubbock phy driver
In-Reply-To: <1417298525-5587-3-git-send-email-dbaryshkov@gmail.com>
References: <1417298525-5587-1-git-send-email-dbaryshkov@gmail.com>
 <1417298525-5587-3-git-send-email-dbaryshkov@gmail.com>
Message-ID: <20150108165834.GH31926@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 30, 2014 at 01:02:04AM +0300, Dmitry Eremin-Solenikov wrote:
> Extract lubbock-specific code from pxa25x_udc driver. As a bonus, phy
> driver determines connector/VBUS status by reading CPLD register. Also
> it uses a work to call into udc stack, instead of pinging vbus session
> right from irq handler.
> 
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  drivers/usb/phy/Kconfig       |  10 ++
>  drivers/usb/phy/Makefile      |   1 +

new phy drivers under drivers/phy only, sorry.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150108/1b0d65ee/attachment.sig>
