From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 29 Sep 2015 14:09:43 +0200
Subject: [linux-sunxi] [PATCH] i2c: mv64xxx: The n clockdiv factor is 0
 based on sunxi SoCs
In-Reply-To: <560813CF.4000807@schinagl.nl>
References: <1443365828-8956-1-git-send-email-hdegoede@redhat.com>
 <560813CF.4000807@schinagl.nl>
Message-ID: <20150929120943.GP7104@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 27, 2015 at 06:05:35PM +0200, Olliver Schinagl wrote:
> Hey Hans,
> 
> On 27-09-15 16:57, Hans de Goede wrote:
> >According to the datasheets to n factor for dividing the tclk is
> >2 to the power n on Allwinner SoCs, not 2 to the power n + 1 as it is
> >on other mv64xxx implementations.
> Ah!
> >
> >I've contacted Allwinner about this and they have confirmed that the
> >datasheet is correct.
> >
> >This commit fixes the clk-divider calculations for Allwinner SoCs
> >accordingly.
> So this explains why all my i2c frequenties are double of what I setup.
> Thanks for taking the time of figuring it out! I'll give it a test hopefully
> soon.

It would have been great to let us know...

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150929/97e805ec/attachment.sig>
