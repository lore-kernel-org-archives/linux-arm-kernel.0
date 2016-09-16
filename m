From: will.deacon@arm.com (Will Deacon)
Date: Fri, 16 Sep 2016 08:45:13 +0100
Subject: [RESEND PATCH] arm64: kgdb: fix single stepping
In-Reply-To: <20160916043218.GA30248@linaro.org>
References: <1429578793-3971-1-git-send-email-takahiro.akashi@linaro.org>
 <0ea7dfad-e25d-2919-2d03-17b850d7ba91@windriver.com>
 <20160916043218.GA30248@linaro.org>
Message-ID: <20160916074513.GI3380@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A Jason appeared!

On Fri, Sep 16, 2016 at 01:32:19PM +0900, AKASHI Takahiro wrote:
> On Thu, Sep 15, 2016 at 08:04:57AM -0500, Jason Wessel wrote:
> > I added the patch to kgdb-next after fixing up the context since it no
> > longer applied to the mainline (
> > https://git.kernel.org/cgit/linux/kernel/git/jwessel/kgdb.git/log/?h=kgdb-next).
> > If there is further discussion on the point above, another patch can be
> > added, but it I am assuming this is the way you desire it to work as
> > there are some other architectures that use the same behaviour.  I do
> > not presently have any ARM64 hardware to validate this particular
> > change.
> > 
> > I also added to the patch a "Cc: linux-stable <stable@vger.kernel.org>"
> > so we can have this appear on some of the older kernels.
> 
> Since Will asked me to split this patch into a few, I need some reworks
> to clarify which hunks in the patch are necessary for which version of kernel.

Yes, splitting the patch would be much better for sorting out the stable
backports too. Jason, please can you drop the patch for now? I don't mind
whether the end result goes via arm64 or kgdb, but we should at least both
agree on it first :)

Will
