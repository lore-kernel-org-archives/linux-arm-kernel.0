From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 7 Sep 2016 16:04:33 +0200
Subject: [PATCH 2/6] pinctrl: sunxi: Add GR8 controller support
In-Reply-To: <CAGb2v66gZ4q4oJV5=xdbzLKKWtbm1PUQMOrm_J9CsLLHObCJhQ@mail.gmail.com>
References: <20160831081817.5191-1-maxime.ripard@free-electrons.com>
 <20160831081817.5191-3-maxime.ripard@free-electrons.com>
 <CAGb2v66gZ4q4oJV5=xdbzLKKWtbm1PUQMOrm_J9CsLLHObCJhQ@mail.gmail.com>
Message-ID: <20160907140433.GA28134@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 08:49:55PM +0800, Chen-Yu Tsai wrote:
> > +       SUNXI_PIN(SUNXI_PINCTRL_PIN(D, 6),
> > +                 SUNXI_FUNCTION(0x0, "gpio_in"),
> > +                 SUNXI_FUNCTION(0x1, "gpio_out"),
> > +                 SUNXI_FUNCTION(0x2, "lcd0"),          /* D6 */
> > +                 SUNXI_FUNCTION(0x3, "emac")),         /* ECRS */
> 
> The cover letter said ethernet was gone?

That was my understanding, I doubled check and it's indeed there. I'll
amend the commit log. Thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160907/d7bdff00/attachment-0001.sig>
