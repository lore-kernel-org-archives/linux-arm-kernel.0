From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Mar 2018 19:09:31 +0100
Subject: [PATCH 2/2] MAINTAINERS: demote ARM port to "odd fixes"
In-Reply-To: <CAKv+Gu8v_+P-VwggmUfE5zq353YN6RqG63YQs+xDZVYUtqc=4Q@mail.gmail.com>
References: <E1ezkgn-0002fO-52@rmk-PC.armlinux.org.uk>
 <CAKv+Gu8v_+P-VwggmUfE5zq353YN6RqG63YQs+xDZVYUtqc=4Q@mail.gmail.com>
Message-ID: <20180325180931.GF10980@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 25, 2018 at 08:27:32AM +0100, Ard Biesheuvel wrote:
> On 24 March 2018 at 15:02, Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > As of the start of 2018, I am no longer paid to support the core 32-bit
> > ARM architecture code.  This means that this code is no longer
> > commercially supported, and is now only supported through voluntary
> > effort.
> >
> 
> Hello Russell,
> 
> It is quite obvious what you are doing here, and FWIW, I personally
> think you should be on the ARM payroll for looking after the 32-bit
> port. However, I don't think it is appropriate to involve the
> community into this. If you cannot afford to spend time on this, the
> right thing to do would be to either share the responsibility with
> co-maintainers (which many architecture ports do these days), or step
> down and let someone else take over entirely.
> 
> In my opinion, letting the ARM port wither to extort money out of ARM
> Ltd. is not something the Linux community should be accessory to.

I find your email offensive.  This is not an attempt to extort money.
I do NOT engage in extortion.  Please apologise for that smear.

This merely reverts the ARM port to the situation that it was prior to
2001.

The fact of the matter is if I'm not getting paid to look after it,
then I'll have other paid work, and anyone who has paid work will know
that paid work takes priority over voluntary work.  That doesn't mean I
have to give up all interest in something I founded.

There are plenty of other kernel maintainers in that position - for
example, Santosh is no longer employed by Texas, but still looks after
the various stuff for TI.

I'm merely pointing out that I'm not going to be spending quite as much
time on the ARM port as I have done in the past - particularly, this
means that I won't have a guaranteed amount of time each week for this
activity.

In the coming weeks, I'm going to be working on the Spectre fixes under
contract with ARM Ltd, and as this will be my primary focus, it will
take priority over voluntary work, such as general maintanence of the
32-bit ARM port.

I'm sure the same goes for other people: work that you get paid for
takes priority over voluntary work.  Anything else would be plain
stupid and suicidal from an employment point of view.

The reality of the 32-bit ARM port situation is that the code base is
stable, and it receives very few patches each kernel cycle, and so it
is entirely reasonable that less time is spent on it.

At no point have I said that I will not merge anything unless I'm paid
for it - again, that would be suicidal and rediculous.

What I do find particularly offensive in your attitude is the
expectation that I'll continue to spend as much time as I have
previously on the ARM port as I have done while being paid for it -
that is entirely unreasonable.  I think you need to alter your
attitude and expectations.

I said in my email that I'm not going to be reading the mailing list
quite as much because given that much of the list traffic is no longer
relevant and sorting through it takes considerable time, I'd rather
spend that time for more productive tasks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
