From: marex@denx.de (Marek Vasut)
Date: Mon, 14 Dec 2015 15:47:10 +0100
Subject: [PATCH V4 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <CAOMZO5ATJEOcp8MqXxUaTYXw-cDHQiYPNJrJPy1XRjNoNsYTKQ@mail.gmail.com>
References: <20151211110700.GD11252@tiger> <201512141541.14107.marex@denx.de>
 <CAOMZO5ATJEOcp8MqXxUaTYXw-cDHQiYPNJrJPy1XRjNoNsYTKQ@mail.gmail.com>
Message-ID: <201512141547.10237.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 14, 2015 at 03:45:16 PM, Fabio Estevam wrote:
> On Mon, Dec 14, 2015 at 12:41 PM, Marek Vasut <marex@denx.de> wrote:
> > Well that's a good idea, but some sort of sane default should be present
> > anyway, right ?
> 
> No, not needed. The bootloader should pass the correct RAM size.
> 
> See imx6qdl-hummingboard and imx6qdl-cubox-i.dtsi for a reference,
> where 'memory' node is not passed.

So, if bootloader does not do the changes to the DT, then what ?
(U-Boot does them, so it would work, but I don't think we should depend on that)

Best regards,
Marek Vasut
