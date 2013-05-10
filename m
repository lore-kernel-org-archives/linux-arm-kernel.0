From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 10 May 2013 09:31:11 +0900
Subject: [GIT PULL] Late Exynos stuff for v3.10
In-Reply-To: <CAOesGMjA5_XUXMcCL3roZiLC1S=ypMoVHn2tF7bzUuKr+eLw2A@mail.gmail.com>
References: <5176B499.1000208@samsung.com> <51770697.7080504@samsung.com>
 <20130424000638.GA9067@quad.lixom.net> <51794E10.1010205@samsung.com>
 <CAOesGMjA5_XUXMcCL3roZiLC1S=ypMoVHn2tF7bzUuKr+eLw2A@mail.gmail.com>
Message-ID: <046301ce4d15$ac1592b0$0440b810$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof Johansson wrote:
> 
> Kukjin,
> 
Hi Olof,

[...]

> > And let me send pull-request again for fix and late dt branch with
> separated
> > branches in a couple of hours not including usb stuff...
> 
> Refresh my memory here, what was the reason for dropping the USB DTS
> updates? (Yes, I am aware it might because I asked you not to send
> them in but I don't remember :-).
> 
Hmm...let me see, yeah, the USB DTS updates dropped because of late
pull-request stuff as you concerned.
http://www.spinics.net/lists/arm-kernel/msg240105.html

Since I didn't want to make a noise at that time, so I dropped for v3.10, it
has been included in my tree for some time though.

> Also, when you drop stuff, please, please don't keep it in your own

Ooops, it's my mistake. I didn't updated my tree not in my local :-(

> for-next branch. The end result is that we'll keep testing something
> on linux-next with the anticipation that it will work when it lands in
> the merge window, when that's not the truth if you're not going to
> send the pull requests up.
> 
> So, if you decide to keep code like this out of the merge window (or
> if we push back at it and say no to it), then remove it from your
> for-next branch as well.
> 
Perfectly right and I agree.

> In particular, the usb phy node for usb2 would ber very good to get in
> for 3.10, since it's a critical piece to get usb2 working on the
> Chromebook.
> 
Yes, I think so, let me sort them out.

Thanks.

- Kukjin
