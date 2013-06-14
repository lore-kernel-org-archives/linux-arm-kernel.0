From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 14 Jun 2013 17:12:52 +0200
Subject: [PATCHv5 0/8] Add I2C support for Allwinner SoCs
In-Reply-To: <20130614140719.GC2929@katana>
References: <1371056017-8166-1-git-send-email-maxime.ripard@free-electrons.com>
 <20130614140719.GC2929@katana>
Message-ID: <20130614151252.GR16699@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Fri, Jun 14, 2013 at 04:07:20PM +0200, Wolfram Sang wrote:
> On Wed, Jun 12, 2013 at 06:53:29PM +0200, Maxime Ripard wrote:
> > Hi,
> > 
> > This patchset adds support for the I2C controller found on most of the
> > Allwinner SoCs, especially the already supported A10 and A13, and the
> > yet to come A31.
> > 
> > This driver leverages the Marvel mv64xxx i2c controller driver, that has
> > an almost identical logic, with a slightly different register layout.
> 
> \o/ Yay, that's more like it. Thanks for the rework!
> 
> > It has been tested on a A13-Olinuxino and an A10s-Olinuxino.
> 
> I'd love to get some Tested-by or other tags for Marvell hardware. Any
> volunteers?

Yes, I'd be more comfortable with Tested-by from Marvell users. I'll
probably be able to get my hands on a Marvell board on monday, if no one
tested it yet.

> > Changes from v4:
> >   * Don't expose the reg offset structure through the platform data
> 
> Commit message 2/9 still speaks about pdata, but I will fix this locally
> if all goes well with this series.
> 
> I will wait a bit more for tags and then pick up patches 1-3. I assume
> the rest goes via arm-soc, let me know if I should take them.

Yes, I'll take it in my tree and push it to arm-soc afterwards.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
