From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Sep 2017 08:42:10 +0200
Subject: [PATCH v2] arm: dts: sun8i: Add the TBS A711 tablet devicetree
In-Reply-To: <CAGb2v66ejAJNLryU4PJYG6_G8Tp+Cndc=rEBFY8y3WibMUTqeA@mail.gmail.com>
References: <20170901134851.20210-1-maxime.ripard@free-electrons.com>
 <CAGb2v66ejAJNLryU4PJYG6_G8Tp+Cndc=rEBFY8y3WibMUTqeA@mail.gmail.com>
Message-ID: <20170904064210.44hrygca2mlxq5hb@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Sep 01, 2017 at 09:55:27PM +0800, Chen-Yu Tsai wrote:
> > +&usbphy {
> > +       usb1_vbus_supply = <&reg_vcc5v0>;
> > +       usb2_vbus_supply = <&reg_vcc5v0>;
> 
> OK. I was expecting something more controllable. If it's always on,
> like tied to system 5V power, then there's little point in adding
> them. It's just a dummy regulator either way.

Even if it works, I'd still prefer to model the regulator tree
properly, instead of having hanging regulators that are used by
something but you don't really know what.

> Otherwise,
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!

> BTW, do you have access to schematics for this tablet?

I do, but I'm not sure how public they are. You have the fex file here
if you're looking for something in there:
https://www.mail-archive.com/linux-sunxi at googlegroups.com/msg21573.html

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170904/11ff5638/attachment.sig>
