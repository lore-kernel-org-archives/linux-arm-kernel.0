From: gregkh@linuxfoundation.org (Greg KH)
Date: Fri, 29 Nov 2013 09:42:23 -0800
Subject: [RFC PATCH] Documentation: devicetree: add description for
 generic bus properties
In-Reply-To: <20131129093713.GC22771@ulmo.nvidia.com>
References: <20131127172806.GC2291@e103592.cambridge.arm.com>
 <20131128203322.GB14689@mithrandir>
 <20131128211009.GA26447@obsidianresearch.com>
 <20131128222232.GF14689@mithrandir>
 <20131128233147.GA19387@obsidianresearch.com>
 <20131129023554.GA14239@kroah.com>
 <20131129093713.GC22771@ulmo.nvidia.com>
Message-ID: <20131129174223.GB5635@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 10:37:14AM +0100, Thierry Reding wrote:
> > > Some of this is a consequence of the push to have the firmware
> > > minimal. As soon as you say the kernel has to configure the address
> > > map you've created a big complexity for it..
> > 
> > Why the push to make firmware "minimal"?  What is that "saving"?  You
> > just push the complexity from one place to the other, just because ARM
> > doesn't seem to have good firmware engineers, doesn't mean they should
> > punish their kernel developers :)
> 
> In my experience the biggest problem here is that people working on
> upstream kernels and therefore confronted with these issues are seldom
> able to track the latest developments of new chips.
> 
> When the time comes to upstream support, most of the functionality has
> been implemented downstream already, so it actually works and there's no
> apparent reason why things should change.

That's a failure of the companies involved.

> Now I know that that's not an ideal situation and upstreaming should
> start a whole lot earlier, but even if that were the case, once the
> silicon tapes out there's not a whole lot you can do about it anymore.
> Starting with upstreaming even before that would have to be a solution,
> but I don't think that's realistic at the current pace of development.

For other companies it is realistic.  I have a whole presentation on
this, and why it even makes good business sense to do it properly (hint,
saves you time and money, who doesn't like that?)

> There's a large gap between how fast new SoCs are supposed to tape out
> and the rate at which new code can be merged upstream. Perhaps some of
> that could be mitigated by putting more of the complexity into firmware
> and that's already happening to some degree for ARMv8. But I suspect
> there's a limit to what you can hide away in firmware while at the same
> time giving the kernel enough information to do the right thing.
> 
> I am completely convinced that our goal should be to do upstreaming
> early and ideally there shouldn't be any downstream development in the
> first place. The reason why we're not there yet is because it isn't
> practical to do so currently, so I'm very interested in suggestions or
> finding ways to improve the situation.

"Practical"?  Heh, other companies know how to do this properly, and
because of that, they will succeed, sorry.

It can be done, the fact that ARM and it's licensees don't want to do
it, doesn't mean it isn't "practical" at all, it's just a failure on
their part to do things in the "correct" way, wasting time and money in
the process.

Oh well, I guess you all have tons of time and money, best of luck with
that :)

greg k-h
