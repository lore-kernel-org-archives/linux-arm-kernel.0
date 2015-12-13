From: andy.gross@linaro.org (Andy Gross)
Date: Sat, 12 Dec 2015 23:07:00 -0600
Subject: [Resend 0/2] Add support for APQ8084 and MSM8916 Regulators
In-Reply-To: <20151212230025.GG579@sirena.org.uk>
References: <1449813694-11211-1-git-send-email-andy.gross@linaro.org>
 <20151212230025.GG579@sirena.org.uk>
Message-ID: <20151213050700.GA3258@Agamemnon.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 12, 2015 at 11:00:25PM +0000, Mark Brown wrote:
> On Fri, Dec 11, 2015 at 12:01:32AM -0600, Andy Gross wrote:
> > This patch set is a resend of the regulator portion of the patches
> > found at:
> > 
> > https://lkml.org/lkml/2015/9/24/561
> 
> These don't apply against current code which suggests that the
> unanswered question I asked about dependencies when they were originally
> posted is still outstanding...

Apologies on messing this up.  The only dependency on these two patches is a
Documentation change I made to clean up the rpm/smd/smd-regulator information.
I had moved the regulator information out of the rpm-smd file and made it into
its own file.

I can add this into the patch set so that all of it is in one place.  I'll also
move the regulator specific document to the regulator documentation directory
where it probably should belong.

Andy
