From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Sep 2012 13:56:54 -0700
Subject: [RFC RESEND 1/4] arm/dts: OMAP: Add timer nodes
In-Reply-To: <504A5884.1010805@ti.com>
References: <1342218413-30116-1-git-send-email-jon-hunter@ti.com>
 <1342218413-30116-2-git-send-email-jon-hunter@ti.com>
 <5000D647.4090200@gmail.com> <500439A8.1050705@ti.com>
 <500D6CAB.4030504@ti.com> <502B67DD.6050904@ti.com>
 <502D0BEE.3010609@ti.com> <20120830201415.GX1303@atomide.com>
 <504A5884.1010805@ti.com>
Message-ID: <20120907205654.GM1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Jon Hunter <jon-hunter@ti.com> [120907 13:27]:
> Hi Tony,
> 
> On 08/30/2012 03:14 PM, Tony Lindgren wrote:
> > * Jon Hunter <jon-hunter@ti.com> [120816 08:05]:
> >> On 08/15/2012 04:11 AM, Vaibhav Hiremath wrote:
> >>>
> >>> Did we get conclude on this? I haven't got anything further on this
> >>> thread, this may block baseport support for the new devices in omap2
> >>> family, like AM33xx and OMAP5.
> >>
> >> Sorry I have been out of the office. However, no update on this so far.
> >> I need to check with Tony if he has any preference for handling this. I
> >> will follow-up with him and keep you posted.
> > 
> > Jon please repost these without the RFC in the subject line
> > assuming the pending comments have been addressed so people
> > can ack them.
> 
> I have been working on updating this series to request timer by their
> capabilities and avoid using a device ID altogether. In the updated
> series using device IDs to request a timer will still work as it does
> today, but not when you boot with DT. I have something working now that
> is booting fine on omap4 with and without DT [1]. However, I need to do
> more thorough testing of the timers in general, probably next week.
> 
> Once I have completed my testing I would like to post for review.
> However, since posting the original series I have been working on some
> needed timer fixes/clean-up which I posted this week [2] for review.
> Ideally I should rebase my DT timer work on my timer fixes series but
> wanted to see what you thought first.

Yeah those all look good to me. Want to do a git branch against
v3.6-rc4 for those once the comments are dealt with so I can pull
it in for testing to start with?

Regards,

Tony
 
> Cheers
> Jon
> 
> [1] https://github.com/jonhunter/linux/tree/dev-dt-timer
> [2] http://marc.info/?l=linux-omap&m=134687188921835&w=2
