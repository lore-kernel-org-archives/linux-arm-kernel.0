From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 3 Nov 2017 09:44:27 +0100
Subject: [PATCH] ARM: sun7i: Add Cubietech Einstein A20 board device-tree
In-Reply-To: <4661874.z7VF5iD9hg@donald>
References: <20171102143534.19353-1-mailinglists@kunz-im-inter.net>
 <20171102155736.qab746tkaspfe47n@flea> <4661874.z7VF5iD9hg@donald>
Message-ID: <20171103084427.rba6zc333fawbrv4@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

On Thu, Nov 02, 2017 at 07:59:04PM +0100, Frank Kunz wrote:
> > > +&mmc2 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&mmc2_pins_a>;
> > > +	vmmc-supply = <&reg_vcc3v3>;
> > 
> > What regulator is this connected to on the PMIC?
> 
> Fixed, On the schematic it is finally connected to 3v0.

Sorry, it wasn't really what I meant. Surely there's a PMIC regulator
providing that 3.0V, you should put that regulator here.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171103/9984c454/attachment.sig>
