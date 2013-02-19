From: balbi@ti.com (Felipe Balbi)
Date: Tue, 19 Feb 2013 11:17:28 +0200
Subject: [PATCH, RFC 7/8] ARM: dts: am4372: initial support
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93EAA85B2@DBDE01.ent.ti.com>
References: <cover.1361186097.git.afzal@ti.com>
 <c9c131c0508b875c0893e8557504372a1564568a.1361186097.git.afzal@ti.com>
 <20130218182240.GA10755@arwen.pp.htv.fi>
 <C8443D0743D26F4388EA172BF4E2A7A93EAA85B2@DBDE01.ent.ti.com>
Message-ID: <20130219091728.GF23197@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 10:10:17AM +0100, Mohammed, Afzal wrote:
> Hi Felipe,
> 
> On Mon, Feb 18, 2013 at 23:52:40, Balbi, Felipe wrote:
> > On Mon, Feb 18, 2013 at 05:08:16PM +0530, Afzal Mohammed wrote:
> 
> > > +		uart1: serial at 44e09000 {
> > > +			compatible = "ti,am4372-uart","ti,omap2-uart";
> > > +			clock-frequency = <48000000>;
> > > +			reg = <0x44e09000 0x2000>;
> > > +			interrupts = <0 72 0x4>;
> > 
> > missing ti,hwmods ??
> 
> It is a deliberate omission. For minimal bootconsole booting, hwmod
> help is not required. Hwmod details would be added gradually later,
> current series doesn't register hwmod.

understood, thanks

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130219/615784bf/attachment.sig>
