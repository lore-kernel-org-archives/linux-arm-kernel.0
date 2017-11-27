From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 27 Nov 2017 19:44:11 +0100
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171127175254.GL31757@n2100.armlinux.org.uk>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <CALAqxLUBWd-mv_3iiFrXLf0ka685t0an89jjduHpT-2jjv5O2Q@mail.gmail.com>
 <20171127175254.GL31757@n2100.armlinux.org.uk>
Message-ID: <20171127184411.GA19577@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/2017 at 17:52:54 +0000, Russell King - ARM Linux wrote:
> I'm actually rather disappointed that Alexandre Belloni has only now
> brought up his dis-satisfaction with the approach after all the effort
> that Jason and myself have put in to it.  It's not like Alexandre was
> not copied on the patches and discussion.
> 
> If Alexandre could not be bothered to bring up his concerns while the
> discussion was on-going in September, and didn't bother raising them
> in October, I'd say that Alexandre's opinion at this point doesn't
> count for much - if it wasn't important to state at the time or for
> a couple of months after, why does it become important to state after
> the thing has been merged.
> 
> Maybe the idea here is basically to waste people's time letting them
> develop a patch for an approach, and then object at the last minute
> to that approach.  Hardly seems fair or even reasonable.
> 

How unfair that is! Really, you are not in a position to make that kind
of comment because you are not even replying to patches in your own
subsystem. But maybe my time doesn't count as much as yours.

I was going to go for a middle ground but now, I'm really more inclined
to just revert the whole stuff.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
