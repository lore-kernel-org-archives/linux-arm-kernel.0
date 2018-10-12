From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 12 Oct 2018 11:57:43 +0200
Subject: [PATCH v3] arm64: new board - Emlid Neutis N5
In-Reply-To: <20181012093523.GA29014@imagebutcher>
References: <1538745949-13188-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539012044-29998-1-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539012044-29998-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <20181010144957.exrlupoph7ovsmdw@flea>
 <9398571539259289@myt4-929fb874f3f2.qloud-c.yandex.net>
 <2d09d6c0-0404-589d-2c34-da846cff4fb8@suse.de>
 <20181012093523.GA29014@imagebutcher>
Message-ID: <20181012095743.llxqyggkhtnsbpaf@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 12, 2018 at 12:35:23PM +0300, Aleksandr Aleksandrov wrote:
> > >> ?+&uart1 {
> > >> ?+ pinctrl-names = "default";
> > >> ?+ pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> > >> ?+ status = "okay";
> > >> ?+};
> > >>
> > >> I guess this is for bluetooth? Have you tested serdev drivers?
> > >>
> > > Yes, bluetooth is connected over uart1.
> > > You mean if I have tested bluetooth stack via serial device?
> > 
> > Not quite, we're missing a child node within uart1 for a serdev driver.
> > Is there no such driver yet for your Bluetooth chipset, or did you not
> > yet check?
> 
> Got it. I haven't checked a serdev driver.
> 
> Maxim, the SoM can't be run without a motherboard. According to your last message
> I don't change dts files, right?

Yep, that works for me.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181012/44e7f915/attachment.sig>
