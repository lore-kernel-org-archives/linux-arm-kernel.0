From: afzal@ti.com (Mohammed, Afzal)
Date: Tue, 19 Feb 2013 09:10:17 +0000
Subject: [PATCH, RFC 7/8] ARM: dts: am4372: initial support
In-Reply-To: <20130218182240.GA10755@arwen.pp.htv.fi>
References: <cover.1361186097.git.afzal@ti.com>
 <c9c131c0508b875c0893e8557504372a1564568a.1361186097.git.afzal@ti.com>
 <20130218182240.GA10755@arwen.pp.htv.fi>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93EAA85B2@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Felipe,

On Mon, Feb 18, 2013 at 23:52:40, Balbi, Felipe wrote:
> On Mon, Feb 18, 2013 at 05:08:16PM +0530, Afzal Mohammed wrote:

> > +		uart1: serial at 44e09000 {
> > +			compatible = "ti,am4372-uart","ti,omap2-uart";
> > +			clock-frequency = <48000000>;
> > +			reg = <0x44e09000 0x2000>;
> > +			interrupts = <0 72 0x4>;
> 
> missing ti,hwmods ??

It is a deliberate omission. For minimal bootconsole booting, hwmod
help is not required. Hwmod details would be added gradually later,
current series doesn't register hwmod.

Regards
Afzal
