From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Jan 2017 18:34:55 +0100
Subject: [GIT PULL] Allwinner conversion to generic pin properties
In-Reply-To: <20170110032120.GJ22261@localhost>
References: <20161226074214.sd53ozm6hvzkdb26@lukather>
 <20170110032120.GJ22261@localhost>
Message-ID: <20170110173455.5vlzp7s3vquerpkm@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Mon, Jan 09, 2017 at 07:21:20PM -0800, Olof Johansson wrote:
> Hi,
> 
> On Mon, Dec 26, 2016 at 08:42:14AM +0100, Maxime Ripard wrote:
> > Hi Arnd, Olof,
> > 
> > Like we discussed it last time, here is a pull request with the
> > convertion patches to the generic pin properties for 4.10.
> > 
> > Thanks,
> > Maxime
> > 
> > The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:
> > 
> >   Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)
> > 
> > are available in the git repository at:
> > 
> >   https://git.kernel.org/pub/scm/linux/kernel/git/mripard/linux.git tags/sunxi-generic-pinconf-for-4.10
> > 
> > for you to fetch changes up to 1edcd36fcb48fe841bcc62eda36c105037d9583c:
> > 
> >   ARM: sunxi: Convert pinctrl nodes to generic bindings (2016-12-26 08:27:11 +0100)
> > 
> > ----------------------------------------------------------------
> > Allwinner conversion to generic pin muxing properties
> > 
> > Here is a list of patches that converts the current DT to the generic pin
> > control and muxing properties, now that the pinctrl driver supports it.
> 
> I dropped the ball on this over the holidays for a few reasons, none of them
> good. Unfortunately we're at -rc3+ now, so I've queued this up in next/dt for
> v4.11 at this point. Hope that's alright.

It is, there's no rush.

> You might want to use your branch as a base for new DT contents for
> v4.11 in case it ends up being conflict-heavy, which would work fine at our
> end.

There might be one minor (and trivial) conflict with one of the fix
I'll send your way, but that pretty much it. All the other patches
were based on this one already.

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170110/4ffabc83/attachment.sig>
