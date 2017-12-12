From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 12 Dec 2017 09:13:35 +0100
Subject: [PATCH] arm64: allwinner: a64: a64-olinuxino: add usb otg
In-Reply-To: <1513058169-25516-1-git-send-email-jagan@amarulasolutions.com>
References: <1513058169-25516-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <20171212081335.3qkqcofdbcfuu5zh@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 12, 2017 at 11:26:09AM +0530, Jagan Teki wrote:
> Add usb otg support for a64-olinuxino board,
> - USB0-ID connected with PH9
> - USB0-VBUSDET connected with PH6
> - USB-DRVVBUS controlled by N_VBUSEN pin from PMIC
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

How was this tested? Did you test the OTG part, or only the peripheral
part?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171212/eaa6fe5e/attachment.sig>
