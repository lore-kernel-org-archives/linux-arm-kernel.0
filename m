From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 Oct 2015 17:22:08 +0000
Subject: [PATCH] get_maintainer: Add subsystem to reviewer output
In-Reply-To: <1446052121.2757.120.camel@perches.com>
References: <1445971482.2757.27.camel@perches.com>
 <CAJKOXPc_w2Dc8LvkCu_d+kjZZmYScXboQrpNWdicT2yfL_5D7Q@mail.gmail.com>
 <20151028082446.GF5828@x1> <56309419.4060908@samsung.com>
 <20151028093907.GP4931@pengutronix.de> <20151028095524.GP5828@x1>
 <5630CA06.7050503@samsung.com>
 <1446050506.2757.109.camel@perches.com> <20151028170116.GI4058@x1>
 <1446052121.2757.120.camel@perches.com>
Message-ID: <20151028172208.GJ4058@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Oct 2015, Joe Perches wrote:

> On Wed, 2015-10-28 at 17:01 +0000, Lee Jones wrote:
> > On Wed, 28 Oct 2015, Joe Perches wrote:
> > 
> > > Reviewer output currently does not include the subsystem
> > > that matched.  Add it.
> > > 
> > > Miscellanea:
> > > 
> > > o Add a get_subsystem_name routine to centralize this
> > > 
> > > Signed-off-by: Joe Perches <joe@perches.com>
> > > ---
> > >  scripts/get_maintainer.pl | 31 ++++++++++++++++---------------
> > >  1 file changed, 16 insertions(+), 15 deletions(-)
> > 
> > It looks like I'm going to have to drop the patch where we actually
> > start using the R: tag properly due to some social, emotional issues.
> 
> Not to mention logical.

Hmm... we continue to disagree on that one.

> > Despite that and not knowing Perl, I believe get_maintainer.pl should
> > be printing out the subsystem next to 'reviewer' as it does for
> > 'maintainer'.
> > 
> > So with that in mind:
> >   Acked-by: Lee Jones <lee.jones@linaro.org>
> 
> It'd be better if you could add a "tested-by:" instead.

Patch works as expected:
  Tested-by: Lee Jones <lee.jones@linaro.org>

Feel free to add my Suggested-by too, based on my belief that this
patch was born out of this comment:

      "I'm sure we can make the output even more similar by listing
      the MAINTAINERS tag after "reviewer" too."

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
