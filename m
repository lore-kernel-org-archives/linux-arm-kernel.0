From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 11 Jun 2013 20:22:51 +0200
Subject: [PATCHv3 1/6] i2c: sunxi: Add Allwinner A1X i2c driver
In-Reply-To: <20130610100847.GG2748@lukather>
References: <1369648843-1640-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369648843-1640-2-git-send-email-maxime.ripard@free-electrons.com>
 <20130605133945.GA2934@katana> <20130605213144.GB14209@lukather>
 <20130610100847.GG2748@lukather>
Message-ID: <20130611182250.GB3376@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 12:08:47PM +0200, Maxime Ripard wrote:
> Hi Wolfram,
> 
> On Wed, Jun 05, 2013 at 11:31:44PM +0200, Maxime Ripard wrote:
> > I guess it would make the code much more complicated for such simple
> > drivers, so I wouldn't push too much for merging, but I guess it's your
> > call.
> 
> I'd like this to be in 3.11, would merging the driver separately for
> this release and merging it with mv64xxx for 3.12 be acceptable to you ?

Thanks for the offer, but the chance of a regression is too high when
switching drivers. Also, configs would need updates then, etc...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130611/e476ea31/attachment-0001.sig>
