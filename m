From: marex@denx.de (Marek Vasut)
Date: Tue, 15 Dec 2015 04:33:10 +0100
Subject: [PATCH V4 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <201512141547.10237.marex@denx.de>
References: <20151211110700.GD11252@tiger>
 <CAOMZO5ATJEOcp8MqXxUaTYXw-cDHQiYPNJrJPy1XRjNoNsYTKQ@mail.gmail.com>
 <201512141547.10237.marex@denx.de>
Message-ID: <201512150433.10573.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, December 14, 2015 at 03:47:10 PM, Marek Vasut wrote:
> On Monday, December 14, 2015 at 03:45:16 PM, Fabio Estevam wrote:
> > On Mon, Dec 14, 2015 at 12:41 PM, Marek Vasut <marex@denx.de> wrote:
> > > Well that's a good idea, but some sort of sane default should be
> > > present anyway, right ?
> > 
> > No, not needed. The bootloader should pass the correct RAM size.
> > 
> > See imx6qdl-hummingboard and imx6qdl-cubox-i.dtsi for a reference,
> > where 'memory' node is not passed.
> 
> So, if bootloader does not do the changes to the DT, then what ?
> (U-Boot does them, so it would work, but I don't think we should depend on
> that)

I just tested that removing the whole memory {} node has no impact.
Would you thus prefer a V5 or can you remove that node yourself when applying?

Best regards,
Marek Vasut
