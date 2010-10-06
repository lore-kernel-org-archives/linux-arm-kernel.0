From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 6 Oct 2010 15:03:38 +0200
Subject: Remove unused default configurations
In-Reply-To: <AANLkTi==1Rj2W8QPuiZdoGHCZ5Q0dJ-_j0xogURQ6nPt@mail.gmail.com>
References: <1284390832-7181-1-git-send-email-vince@kyllikki.org>
	<AANLkTi==1Rj2W8QPuiZdoGHCZ5Q0dJ-_j0xogURQ6nPt@mail.gmail.com>
Message-ID: <20101006130338.GH29673@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 06, 2010 at 10:46:48AM +0300, Amit Kucheria wrote:
> On Mon, Sep 13, 2010 at 6:13 PM, Vincent Sanders <vince@kyllikki.org> wrote:
> >
> > Several default configurations have failed to build for the entire
> > 2.6.36 cycle. There are several causes to these faliures. The exact
> > issues can be tracked on http://armlinux.simtec.co.uk/kautobuild/
> >
> > Obviously the maintainers are not using these default configurations
> > because if they were they would have fixed the build issues by now.
> >
> > As Linus has made it very clear the number of default configurations
> > must be reduced as much as possible I have come up with the following
> > series which will remove these nine unused configurations. This will
> > reduce our build coverage by ten machines as all but one are a single
> > config per machine.
> >
> > ?msm_defconfig ? ? ? ? ? ? ? | ? 72 ------------------
> > ?mx1_defconfig ? ? ? ? ? ? ? | ? 90 -----------------------
> > ?mx51_defconfig ? ? ? ? ? ? ?| ?171 --------------------------------------------
> 
> Could we please keep mx51?
> 
> I'll attempt to fix the problems.
No need to hurry, the problems are already solved in Linus' and Sascha's
trees. :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
