From: hchaumette@adeneo-embedded.com (Hubert Chaumette)
Date: Tue, 22 Apr 2014 18:09:12 +0200
Subject: [PATCH] ARM: i.MX6: Add OF configuration support for ksz9031
In-Reply-To: <20140416080322.GA11602@dragon>
References: <1397466496-24750-1-git-send-email-hchaumette@adeneo-embedded.com>
 <20140416080322.GA11602@dragon>
Message-ID: <1398182952.1593.20.camel@EMBLYSD005.adetelgroup.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le mercredi 16 avril 2014 ? 16:03 +0800, Shawn Guo a ?crit :
> On Mon, Apr 14, 2014 at 11:08:16AM +0200, Hubert Chaumette wrote:
> > - Adds support for ksz9031 PAD skew configuration over devicetree
> > - Removes hard-coded pad skew configuration for imx6q-sabrelite, now redundant
> >   with arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> > 
> > Tested on congatec conga-QEVAL board with conga-QMX6 module.
> > 
> > This patch is based on Anatolij Gustschin's patch from
> > http://www.spinics.net/lists/arm-kernel/msg319771.html
> > 
> > Signed-off-by: Hubert Chaumette <hchaumette@adeneo-embedded.com>
> > ---
> >  arch/arm/mach-imx/mach-imx6q.c |  45 ----------
> >  drivers/net/phy/micrel.c       | 185 ++++++++++++++++++++++++++++++++++++++++-
> 
> You should probably leave mach-imx6q.c unchanged, because dropping the
> phy fix-up from there may break old DTBs.  And the changes on micrel.c
> should be submitted to net maintainer.
> 
> Shawn

I've re-sent it without the changes to mach-imx6q.c. Thanks for your
review.

Regards,
Hubert
