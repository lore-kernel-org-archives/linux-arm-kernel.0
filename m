From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 29 Nov 2017 15:37:29 +0000
Subject: [PATCH v5 00/30] ARM Scalable Vector Extension (SVE)
In-Reply-To: <20171129152140.GD10650@arm.com>
References: <1509465082-30427-1-git-send-email-Dave.Martin@arm.com>
 <877eu9dt3n.fsf@linaro.org> <20171129152140.GD10650@arm.com>
Message-ID: <20171129153107.GT12608@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 03:21:40PM +0000, Will Deacon wrote:
> On Wed, Nov 29, 2017 at 03:04:12PM +0000, Alex Benn?e wrote:
> > 
> > Dave Martin <Dave.Martin@arm.com> writes:
> > 
> > > This series implements Linux kernel support for the ARM Scalable Vector
> > > Extension (SVE). [1]  It supersedes the previous v3: see [3] for link
> > > and full cover letter.
> > >
> > > This is a minor update to v4, but does contain a couple of important
> > > fixes.
> > <snip>
> > 
> > I seem to have run into a regression with normal non-SVE sigcontexts
> > while trying to run consecutive RISU runs in the Foundation Model. I'm
> > failing to get repeatable results playing back a previous --master run.
> > It works OK with the default Debian kernel.
> > 
> > What is the current status of the tree? I'd like to try an narrow it
> > down but I seem to recall it was now in a next tree somewhere?
> 
> This is in mainline now, so please give a 4.15-rc1 build a spin. If there's
> a user-visible regression then we need to get to the bottom of it ASAP.
> 
> Will

The other significant change was in v4.13, where the signal frame
parser rework landed.

What upstream version is your known-good Debian kernel based on?

Cheers
---Dave
