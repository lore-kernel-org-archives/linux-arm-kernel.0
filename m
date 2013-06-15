From: wsa@the-dreams.de (Wolfram Sang)
Date: Sat, 15 Jun 2013 13:36:10 +0200
Subject: [PATCHv5 0/8] Add I2C support for Allwinner SoCs
In-Reply-To: <20130614151252.GR16699@lukather>
References: <1371056017-8166-1-git-send-email-maxime.ripard@free-electrons.com>
 <20130614140719.GC2929@katana> <20130614151252.GR16699@lukather>
Message-ID: <20130615113609.GB2938@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 05:12:52PM +0200, Maxime Ripard wrote:
> Hi Wolfram,
> 
> On Fri, Jun 14, 2013 at 04:07:20PM +0200, Wolfram Sang wrote:
> > On Wed, Jun 12, 2013 at 06:53:29PM +0200, Maxime Ripard wrote:
> > > Hi,
> > > 
> > > This patchset adds support for the I2C controller found on most of the
> > > Allwinner SoCs, especially the already supported A10 and A13, and the
> > > yet to come A31.
> > > 
> > > This driver leverages the Marvel mv64xxx i2c controller driver, that has
> > > an almost identical logic, with a slightly different register layout.
> > 
> > \o/ Yay, that's more like it. Thanks for the rework!
> > 
> > > It has been tested on a A13-Olinuxino and an A10s-Olinuxino.
> > 
> > I'd love to get some Tested-by or other tags for Marvell hardware. Any
> > volunteers?
> 
> Yes, I'd be more comfortable with Tested-by from Marvell users. I'll
> probably be able to get my hands on a Marvell board on monday, if no one
> tested it yet.

Applied to for-next, thanks, especially for respinning the driver! Also
thanks to the testers! Great community work here \o/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130615/9a5121d9/attachment.sig>
