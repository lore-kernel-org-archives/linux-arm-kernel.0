From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 27 Jan 2014 13:52:53 -0800
Subject: [PATCH 0/2] Enable clock controllers on MSM
In-Reply-To: <69BE1300-36E8-400B-BD77-DB89740C10D2@codeaurora.org>
References: <1389921904-3777-1-git-send-email-sboyd@codeaurora.org>
 <878uu6y5im.fsf@paris.lan>
 <DBC6E587-D188-4DA7-B898-D1DF34613320@codeaurora.org>
 <CAOesGMgDg5KyvV9Gj0NeDnWYPQN+EZBzm18mSTku+VZOApVxyA@mail.gmail.com>
 <69BE1300-36E8-400B-BD77-DB89740C10D2@codeaurora.org>
Message-ID: <20140127215253.4167.94988@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Kumar Gala (2014-01-23 13:57:58)
> 
> On Jan 23, 2014, at 2:43 PM, Olof Johansson <olof@lixom.net> wrote:
> 
> > On Thu, Jan 23, 2014 at 11:59 AM, Kumar Gala <galak@codeaurora.org> wrote:
> >> 
> >> On Jan 23, 2014, at 11:25 AM, Kevin Hilman <khilman@linaro.org> wrote:
> >> 
> >>> Stephen Boyd <sboyd@codeaurora.org> writes:
> >>> 
> >>>> These patches add the clock controller nodes, enable the clock drivers
> >>>> on MSM based platforms, and hook it up enough to get the serial console
> >>>> working. This is based on the merge of Mike's clk-next branch with
> >>>> linux-next-20140116. The changes need the clk-next branch because that's
> >>>> where the DTS include files landed.
> >>> 
> >>> I forgot to repond to this earlier, but I tested this on top of -next
> >>> and it gets the dragonboard booting w/mainline.  Yay!
> >>> 
> >>>> Perhaps this can be applied after 3.14-rc1 is out?
> >>> 
> >>> Yeah, sounds good.
> >>> 
> >>> Kevin
> >> 
> >> We?ll need arm-soc to pull in the clk changes from Mike?s tree for that.
> > 
> > They're queued for this merge window, right? If so, they'll be in -rc1
> > and the dependency will be solved before we apply the patches.
> > 
> 
> Yeah, they look like they are in Mike?s pull request for Linus.  So hopefully they?ll show up in -rc1 (wasn?t sure if Mike intended them for 3.14 or not).

They are in the second pull request which I just sent today.

Regards,
Mike

> 
> What?s the feeling about pushing DT and defconfig changes into 3.14 (or do we just queue them up for 3.15)?
> 
> - k
> 
> -- 
> Employee of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
> 
