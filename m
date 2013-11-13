From: olof@lixom.net (Olof Johansson)
Date: Wed, 13 Nov 2013 13:34:42 -0800
Subject: [PATCH] spi: davinci: Fix the build warning with CONFIG_ARM_LPAE=y
In-Reply-To: <20131113132952.GK878@sirena.org.uk>
References: <1380567179-20174-1-git-send-email-santosh.shilimkar@ti.com>
 <20131001104840.GL19304@sirena.org.uk>
 <CAOesGMhRoEvsQoSvoCSY=zm71zeZec3MG_FpHOy1zUkYronZcw@mail.gmail.com>
 <20131113132952.GK878@sirena.org.uk>
Message-ID: <20131113213442.GA3294@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 01:29:52PM +0000, Mark Brown wrote:
> On Tue, Nov 12, 2013 at 10:38:13PM -0800, Olof Johansson wrote:
> > On Tue, Oct 1, 2013 at 3:48 AM, Mark Brown <broonie@kernel.org> wrote:
> 
> > > Applied, thanks.
> 
> > These warnings are showing up (again?), so wherever it was applied is
> > not making it into -next. Did it fall between the cracks?
> 
> Looks lie it never got pushed and nobody looked at the warnings for over
> a month.  Oh well, sorry about that.

No worries.

I've been eyeing the warnings but not doing anything about it. Didn't
notice that there was a patch until I started looking for existing
patches to take care of it (and post patches where needed).


-Olof
