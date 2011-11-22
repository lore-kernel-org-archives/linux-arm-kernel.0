From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 22 Nov 2011 23:03:15 +0000
Subject: -next fails to boot as of today on S3C6410
In-Reply-To: <20111122225847.GA3005@opensource.wolfsonmicro.com>
References: <20111122192741.GG30583@opensource.wolfsonmicro.com>
 <20111122193124.GB9581@n2100.arm.linux.org.uk>
 <20111122193957.GH30583@opensource.wolfsonmicro.com>
 <20111122222135.GB7845@gallagher>
 <20111122225847.GA3005@opensource.wolfsonmicro.com>
Message-ID: <20111122230315.GC7845@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 10:58:49PM +0000, Mark Brown wrote:
> On Tue, Nov 22, 2011 at 10:21:35PM +0000, Jamie Iles wrote:
> > On Tue, Nov 22, 2011 at 07:39:57PM +0000, Mark Brown wrote:
> 
> > > Thanks.  Note that I'm not 100% sure I believe the bisection result as
> > > reverting didn't fix the issue and I've stared at the code a bit without
> > > seeing anything that set off alarm bells.
> 
> > No, you're right - this is the offending commit.  It actually needs 
> > this[1] fix and things should be okay.
> 
> > Thomas, Rob, would one of you be able to apply this please?  I'm not 
> > sure if this would normally go through Grant or not.
> 
> Gah, right.  I'll give this a test tomorrow.
> 
> You *really* should point out dependencies like this when sending
> patches so we can avoid this sort of bisection breakage when posting
> things so that whoever's applying the patches can avoid introducing this
> sort of breakage and so that we don't have people like me sitting trying
> to work out if they did something thick.

Sorry about that.  At the time I thought the fix was small enough that 
it would get applied quickly without problems and would be in way before 
these patches, but I didn't follow it up early enough.  I'll make sure 
that it doesn't happen again though.

Thanks,

Jamie
