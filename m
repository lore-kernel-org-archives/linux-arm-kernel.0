From: bp@suse.de (Borislav Petkov)
Date: Tue, 9 Sep 2014 17:45:25 +0200
Subject: [GIT PULL 2/2] SOCFPGA driver updates for 3.18
In-Reply-To: <3081326.KgOEtsBgKv@wuerfel>
References: <1409847105-27241-1-git-send-email-dinguyen@opensource.altera.com>
 <1409847105-27241-2-git-send-email-dinguyen@opensource.altera.com>
 <3081326.KgOEtsBgKv@wuerfel>
Message-ID: <20140909154525.GC4054@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 09, 2014 at 04:59:07PM +0200, Arnd Bergmann wrote:
> On Thursday 04 September 2014 11:11:45 dinguyen at opensource.altera.com wrote:
> > Hi Arnd, Kevin and Olof,
> > 
> > Please consider pulling this patch for v3.18. Boris had given me permission to
> > take this patch together with it's DTS component. The DTS portion was in the
> > previous pull request.
> 
> I have no objections to the code, but I don't understand what you gain
> from merging it through arm-soc. There is no dependency between the
> driver and the dts entries in any way, you just need to have both in order
> for things to work.

This is why I wanted them to go together, for completeness...

> We can always pull in drivers with permission from the maintainer when there
> is a good reason to do that, but I don't see that reason for this patch,
> so I'd prefer to have Boris merge it through his tree, unless I'm missing
> something.

... but then Dinh suggested he takes it so... In any case, I don't care
who takes it. Normally I'd take them without much ado but I'd suggest
we make an exception this one time since I'm on vacation with flaky
interwebs connection and doing pull requests and merging patches doesn't
work as smoothly.

So Arnd, if you take it this one time only, I'd appreciate it. Otherwise
it'll have to wait until I get back.

Thanks.

-- 
Regards/Gruss,
    Boris.
--
