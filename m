From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 28 Jul 2015 09:30:41 +0100
Subject: [PATCH v4 2/2] dt: power: st: Provide bindings for ST's OPPs
In-Reply-To: <20150728074709.GA13710@linux>
References: <1438010430-5802-1-git-send-email-lee.jones@linaro.org>
 <1438010430-5802-2-git-send-email-lee.jones@linaro.org>
 <20150728022936.GB1229@linux> <20150728073439.GK21114@x1>
 <20150728074709.GA13710@linux>
Message-ID: <20150728083041.GL14943@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Jul 2015, Viresh Kumar wrote:

> On 28-07-15, 08:34, Lee Jones wrote:
> > I disagree.  For one, only 'opp-hz' is defined in ./opp.tx.  Secondly
> 
> There are other properties in op.txt like turbo, opp-suspend, latency,
> etc.. which can be useful for your platform to. Its not used for now
> is a different thing.
> 
> > it would be annoying to have to have to keep jumping between documents
> > to obtain the whole picture.  Finally, generic bindings are repeated
> > in platform/device specific documentation all the time.  Grep for
> > 'clocks' or 'regulator-* or 'interrupts' or 'reg' or 'clock-frequency'
> 
> Yeah, I agree. I am not against that. What I meant to say was that its
> an extension to opp-v2. So whatever is present in opp-v2 can be used
> by ST's driver, without mentioning that here as well.
> 
> > (which IMHO I think you should have used instead of 'opp-hz', but
> > that's by the by), or any number of other generic properties.
> 
> Hmm, probably yes. See I don't know everything :)
> 
> > > @Rob/Stephen: Please respond before it is late :)
> > 
> > No one knows this stuff better than you.  If you can't think of an
> > already existing binding that could suit to portray our 'cuts' and
> > 'substrate' information (with a similar way to support our "all cuts"
> > and "all substrates" options, then there probably isn't one. ;)
> 
> Oh, I wasn't saying that there is an existing binding for supporting
> your case. But if we want to move the cuts property to the generic
> bindings so that others can use it. :)

Okay, so what are we waiting for before you'd be prepared to Ack the
binding?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
