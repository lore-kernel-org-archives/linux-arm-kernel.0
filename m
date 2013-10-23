From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 23 Oct 2013 21:06:11 +0200
Subject: [Ksummit-2013-discuss] ARM topic: Is DT on ARM the solution, or
 is there something better?
In-Reply-To: <20131023173032.GB5208@netboy>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020220839.GT2443@sirena.org.uk>
 <5264576F.6050307@wwwdotorg.org>
 <alpine.LFD.2.03.1310201911190.1951@syhkavp.arg>
 <20131021091555.GB21518@ulmo.nvidia.com>
 <20131021170711.GA5256@netboy>
 <20131022092410.GB15640@ulmo.nvidia.com>
 <20131023173032.GB5208@netboy>
Message-ID: <20131023190610.GD7863@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 23, 2013 at 07:30:33PM +0200, Richard Cochran wrote:
> On Tue, Oct 22, 2013 at 11:24:11AM +0200, Thierry Reding wrote:
> > 
> > Oh, I've been doing that for quite a while. In fact the patches that
> > gave rise to the current frustration have been in a separate tree in
> > various forms for over a year. But that's not what we want, is it?
> 
> I can't see anything wrong with that. Your code is not the first to
> have to wait for a long time before being finally merged. Think of
> alsa, or of the pps stuff, or wakelocks, or preempt_rt, etc, etc.

Heh... that's no news for me.

> As an end user, I don't mind waiting for a feature if that means
> stability and QA. If I get impatient, still I always have the choice
> to take a development version. But I do not want to be forced to take
> unfinished work in a released kernel.

This isn't about stability and QA. The DT binding has nothing to do
whatsoever with the quality of the code. Also in many cases with DT we
end up with work that's actually finished and pretty well tested, and
the only thing blocking it is the DT binding.

> > I
> > used to think that we actively wanted people to contribute code back
> > upstream, so telling everyone to keep code in their own trees isn't
> > helping anyone.
> 
> Actually, I mean to propose that the ARM/DT people use a single
> marshaling tree, one step away in the process from mainline.

I don't think fragmentation of that sort will do us any good. It will
only make it harder to get things merged because they get developed
outside of the upstream process.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131023/8692bdc8/attachment.sig>
