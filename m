From: dianders@chromium.org (Doug Anderson)
Date: Tue, 29 Apr 2014 09:51:20 -0700
Subject: [PATCH v2 0/7] Add cros_ec changes for newer boards
In-Reply-To: <20140429082146.GE29462@lee--X1>
References: <1398185154-19404-1-git-send-email-dianders@chromium.org>
 <20140423123240.GA640@lee--X1> <5357E832.1000806@wwwdotorg.org>
 <CAD=FV=XbjeOR+A-ZVYgOT69gsdp-YrjbkGrjL2Vf4F31ZkGXTA@mail.gmail.com>
 <CAD=FV=UWnLLzqzmrt0z=38iDOBSRJJLNAG8PL0GSHt1758ACcg@mail.gmail.com>
 <20140428091914.GK6264@lee--X1>
 <CAD=FV=UEwfNX+uf70OV4LB39s=mJyxTkC63g4iYrE7hcvyEdgw@mail.gmail.com>
 <20140429082146.GE29462@lee--X1>
Message-ID: <CAD=FV=VXPDdSx8Dxng8miu=wcdnDJPAheSD8BMXq0WdjJeJEUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lee,

On Tue, Apr 29, 2014 at 1:21 AM, Lee Jones <lee.jones@linaro.org> wrote:
> I don't use TBs for MFD yet, as I've never seen the need.  The current
> WoW is to only create extra branches when I have patch{es, sets} to
> share.  If I start using a more TB focused methodology it will be
> insinuated that the branches are stable - I like the fact that this is
> _not_ the case.  Currently I am able to rebase, rework and reorder the
> repo as and when I see fit, and do regularly. Except the IBs of course.

OK.

>> Patches #1 - #5 are bonafide bugfixes irrespective of the i2c tunnel.
>
> I only want to create an IB if I know it's going to be used, else I'd
> prefer the patches remain transient.  Why are you so keen to rush into
> having these patches applied?  They _will_ make it into v3.15, whether
> they are applied immediately or after a length of time (in the case
> that Wolfram does not respond).

No strong reason, and it's actually not even a huge deal if they make
it to 3.15 or in 3.16.  Having outstanding patches simply increases
the number of things that I need to keep track of / check up on.  If
patches are good to go and reviewed I like to get them landed.

Another reason I'd love to see patches landed sooner is that it will
unblock me sending the next set of patches up.  I collected all of the
most important patches in this series, but there are a bunch of other
patches in our tree that would be nice to eventually send up.  At the
moment I'm in a position where I can dedicate a reasonable amount of
time to upstreaming.  It's likely that before long I will get sucked
into tight deadlines and will have to squeeze upstreaming in among
other priorities.

I see a response from Wolfram now, so I'll spin a V2 in the next day
or two with changes to the tunnel driver.  I'm at ELC so my hacking
time may be limited.

-Doug
