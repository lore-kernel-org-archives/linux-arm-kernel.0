From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 27 Nov 2017 20:31:35 +0100
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171127185352.GN31757@n2100.armlinux.org.uk>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <CALAqxLUBWd-mv_3iiFrXLf0ka685t0an89jjduHpT-2jjv5O2Q@mail.gmail.com>
 <20171127175254.GL31757@n2100.armlinux.org.uk>
 <20171127184411.GA19577@piout.net>
 <20171127185352.GN31757@n2100.armlinux.org.uk>
Message-ID: <20171127193135.GA21126@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/2017 at 18:53:52 +0000, Russell King - ARM Linux wrote:
> On Mon, Nov 27, 2017 at 07:44:11PM +0100, Alexandre Belloni wrote:
> > On 27/11/2017 at 17:52:54 +0000, Russell King - ARM Linux wrote:
> > > I'm actually rather disappointed that Alexandre Belloni has only now
> > > brought up his dis-satisfaction with the approach after all the effort
> > > that Jason and myself have put in to it.  It's not like Alexandre was
> > > not copied on the patches and discussion.
> > > 
> > > If Alexandre could not be bothered to bring up his concerns while the
> > > discussion was on-going in September, and didn't bother raising them
> > > in October, I'd say that Alexandre's opinion at this point doesn't
> > > count for much - if it wasn't important to state at the time or for
> > > a couple of months after, why does it become important to state after
> > > the thing has been merged.
> > > 
> > > Maybe the idea here is basically to waste people's time letting them
> > > develop a patch for an approach, and then object at the last minute
> > > to that approach.  Hardly seems fair or even reasonable.
> > > 
> > 
> > How unfair that is! Really, you are not in a position to make that kind
> > of comment because you are not even replying to patches in your own
> > subsystem. But maybe my time doesn't count as much as yours.
> 
> You are, yet again, wrong.
> 
> I am in a position to make the comment because it was me who identified
> the problem, put in the hours to work on, develop and extensively test
> Jason's patch.  So, it's partly my time that you seem to be wasting,
> and that gives me every right to complain at this point.
> 
> You, on the other hand, were copied with every single email, and did
> nothing to discuss the issue except for the "easy" bits when I posted
> a relatively smaller patch - but you ignored the bigger issue.
> 

And this is exactly what you do with other people patches/time when you
don't like their changes.
You simply ignore the patch series until they go away.

> Now that the patch was merged, you throw your toys out of the pram and
> start blaming everyone else for "silently" merging the patch and how it
> wasn't sent to the right email addresses.
> 

I would really expect people merging code in any subsystem to wait for
the ack of the maintainer of that subsystem.

I didn't complain about any missing email addresses, I said the RTC ML
was not copied but that is didn't matter.

You're not even happy about the patch that was merged because it was the
wrong one!

> And now that someone dare criticise your abilities, you decide to revert
> the change and restore Linux back to a crippled state.
> 
> Honestly, I don't _care_ if you revert it and if you want to cripple
> the kernel as a result in regards to this issue, I can carry the patch
> ad infinitum, no skin off my back.  You're only going to be hurting
> yourself and other people through your spite by doing that revert.
> 
> I suggest you take a good long hard look at what you're about to do and
> ask whether you are being reasonable, given that it's taken you over
> two months whole months to raise any _technical_ issues with the approach
> that Jason and myself came up with.
> 

What I don't get is that it has been broken for almost 5 years and now
you seem to think it has to be fixed urgently.

On my side, I want to take the opportunity to think about systohc before
adding an ABI that we will maybe regret later.

Again, I agree the 0.5s offset is crap and basically only works for
mc146818 and that has to be fixed somehow.

Maybe I could have replied earlier but that has been my intent from the
start but I didn't have the time to look at the history of it before.

It was not my intent to waste anyone's time.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
