From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 20 May 2010 00:15:59 -0700
Subject: Samsung touchscreen updates
In-Reply-To: <20100519064138.GG4720@trinity.fluff.org>
References: <1274249542-28795-1-git-send-email-ben-linux@fluff.org>
	<888AB3A0-262F-4603-9B83-B8B6A4D25DC1@gmail.com>
	<20100519064138.GG4720@trinity.fluff.org>
Message-ID: <20100520071559.GD8080@core.coreip.homeip.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 19, 2010 at 07:41:38AM +0100, Ben Dooks wrote:
> On Tue, May 18, 2010 at 11:34:51PM -0700, Dmitry Torokhov wrote:
> > On May 18, 2010, at 11:12 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> >
> >> Dimitry, this is a set of updates for the Samsung platform support for
> >> touchscreen devices and the drivers/input/touchscreen items for the
> >> s3c2410_ts driver.
> >>
> >> Since the changes have some interedependency, I would like permission
> >> to merge this via the Samsung platform tree with your acknowledgement
> >> for the drivers/input/touchscreen items.
> >>
> >> The arch/arm/* portions of this patchset have been included as FYI and
> >> to show other interested parties what is goign on.
> >>
> >> Please let me know what you think.
> >
> > Yeah, it all looks Ok, please merge through your tree.
> 
> Just rememberred I acked Maurus' original 64xx patch, did that get
> merged anywhere as I couldn't find it in the tree listed in MAINTAINERS?
> 

It looks like it got lost in my queue. The patch looks sane, would you
mind merging it with the rest of changes for s3c2140?

Thanks.

-- 
Dmitry
