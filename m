From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 1 Sep 2014 09:54:13 +0200
Subject: [GIT PULL] Allwinner DT additions for 3.17, take 2
In-Reply-To: <20140823042022.GB11268@localhost>
References: <20140731095158.GA14197@lukather>
 <CAGb2v677G33AC2C8sV2tBthVfF=WdG7673g9PggCoUuJ1xtXuw@mail.gmail.com>
 <20140821211500.GU15297@lukather>
 <20140823042022.GB11268@localhost>
Message-ID: <20140901075413.GK15297@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Fri, Aug 22, 2014 at 09:20:22PM -0700, Olof Johansson wrote:
> On Thu, Aug 21, 2014 at 11:15:00PM +0200, Maxime Ripard wrote:
> > On Mon, Aug 18, 2014 at 02:19:07PM +0800, Chen-Yu Tsai wrote:
> > > Hi,
> > > 
> > > On Thu, Jul 31, 2014 at 5:51 PM, Maxime Ripard
> > > <maxime.ripard@free-electrons.com> wrote:
> > > > Hi Arnd, Kevin, Olof,
> > > >
> > > > Here are a rather small (and late) pull request for the Allwinner DTs
> > > > that comes on top of the previous one.
> > > >
> > > > It's basically just a fix, so there's no real need to merge it by
> > > > -rc1, it can definitely be postponed to a later 3.17-rc.
> > > >
> > > > Thanks,
> > > > Maxime
> > > >
> > > > The following changes since commit c220aec2bb793bf5a1fb451fd3e4db87654c5ba5:
> > > >
> > > >   ARM: dts: sun6i: Add Merrii A31 Hummingbird support (2014-07-18 22:40:37 +0200)
> > > >
> > > > are available in the git repository at:
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-dt-for-3.17-2
> > > >
> > > > for you to fetch changes up to 495bccf3917b04c6727d720b56620e265c693ace:
> > > >
> > > >   ARM: dt: sun6i: Add #address-cells and #size-cells to i2c controller nodes (2014-07-28 11:34:39 +0200)
> > > >
> > > > ----------------------------------------------------------------
> > > > Allwinner DT changes, take 2
> > > >
> > > > Only a single patch in here that fixes a DTC warning.
> > > >
> > > > ----------------------------------------------------------------
> > > > Chen-Yu Tsai (1):
> > > >       ARM: dt: sun6i: Add #address-cells and #size-cells to i2c controller nodes
> > > 
> > > It seems this patch didn't make it into v3.17-rc1.
> > 
> > Indeed. Arnd, Olof, Kevin, any news on this pull request?
> 
> Missed it. Will pull it for fixes.

I didn't see it in your latest pull request to Linus, is this normal?

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140901/17f2dc30/attachment.sig>
