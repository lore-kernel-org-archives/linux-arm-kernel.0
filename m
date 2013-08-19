From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 19 Aug 2013 13:23:34 +0200
Subject: [PATCHv3 4/9] pinctrl: sunxi: Add Allwinner A20 pins set
In-Reply-To: <20130812083319.GN2911@lukather>
References: <1375610330-18185-1-git-send-email-maxime.ripard@free-electrons.com>
 <1375610330-18185-5-git-send-email-maxime.ripard@free-electrons.com>
 <20130812083319.GN2911@lukather>
Message-ID: <20130819112334.GK3173@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 10:33:19AM +0200, Maxime Ripard wrote:
> Hi Linus,
> 
> On Sun, Aug 04, 2013 at 11:58:45AM +0200, Maxime Ripard wrote:
> > The Allwinner A20 is pin-compatible with the older A10, so the two pin
> > set are quite similar. However, since the A20 has new features, we can't
> > just use the A10 pin set as is, and we need to define our own for the
> > A20.
> 
> I'd like this to get merged in 3.12, do you have any comments on this
> patch?
> 
> It's mostly just another round of pin sets additions for yet another
> SoC, like we already had a few times.
> 
> Hopefully, it will be the end of it, unless if Allwinner release a new
> SoC.
> 
> The only missing feature now is the gpio irq support for the A31 that
> had a slightly different interrupts handling. Anyway, this support will
> likely be in 3.13.

Ping again :)

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130819/b35d8166/attachment.sig>
