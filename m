From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 12 Jan 2017 17:52:44 +0100
Subject: [linux-sunxi] Re: [PATCH 4/5] ARM: dts: sunxi: add dtsi file for
 V3s SoC
In-Reply-To: <20170111065638.uW1SQ7Kq@smtp3m.mail.yandex.net>
References: <20170111065638.uW1SQ7Kq@smtp3m.mail.yandex.net>
Message-ID: <20170112165244.js3qrgo2nbazycmn@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2017 at 11:56:32AM +0800, Icenowy Zheng wrote:
> 
> 2017?1?11? 02:21? Maxime Ripard <maxime.ripard@free-electrons.com>???
> >
> > On Tue, Jan 03, 2017 at 11:16:28PM +0800, Icenowy Zheng wrote: 
> > > + uart0_pins_a: uart0 at 0 { 
> > > + pins = "PB8", "PB9"; 
> > > + function = "uart0"; 
> > > + bias-pull-up; 
> >
> > Why do you need a pullup here? 
> 
> I think TX needs one, but RX do not need.

That's (at best) board specific. So it belongs in the DTS if it's
truely needed.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170112/f8f7e9e4/attachment-0001.sig>
