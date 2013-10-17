From: will.deacon@arm.com (Will Deacon)
Date: Thu, 17 Oct 2013 13:15:30 +0100
Subject: New big-endian patch series against 3.12-rc4
In-Reply-To: <20131017140712.6312f71a@skate>
References: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
 <20131017140712.6312f71a@skate>
Message-ID: <20131017121529.GL18765@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 17, 2013 at 01:07:12PM +0100, Thomas Petazzoni wrote:
> On Wed,  9 Oct 2013 00:34:16 +0200, Ben Dooks wrote:
> 
> > Russell, if possible could this go into -next and then if everything
> > I can issue a pull request for it.
> 
> Shall I suggest that you post the patches into Russell patch's system?
> 
> Your patch set has been around for a long while, has received Acked-by,
> Reviewed-by and/or Tested-by from a number of different people,
> including core ARM persons, so I believe it's time to push them through
> Russell patch's system, to at least get some reaction from Russell,
> since he has apparently completely ignored your pull requests until now.
> 
> Maybe Nicolas or Will can comment on the best way to make things move
> forward with this patch set.

There are a good number of acks on this now, so I think a pull request to
rmk with the latest version based on something like -rc3 (since that's where
devel-stable is) would be the best thing to do. Then they can enjoy some
time in -next and we can iron out any conflicts that might crop up.

Will
