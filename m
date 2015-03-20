From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Mar 2015 09:21:38 -0700
Subject: [PATCH v7 5/6] ARM: dts: add wl12xx/wl18xx bindings
In-Reply-To: <87bnjnfz1t.fsf@kamboji.qca.qualcomm.com>
References: <1426696710-6891-1-git-send-email-eliad@wizery.com>
 <1426696710-6891-6-git-send-email-eliad@wizery.com>
 <550AD7C1.2030405@gmail.com>
 <CAB3XZEfpD7YkwdU7OJJaNFy=MnYVY3-fOVxkA48Vu01LzU0GFg@mail.gmail.com>
 <20150319212505.GN31346@atomide.com>
 <87h9tgi4sg.fsf@kamboji.qca.qualcomm.com>
 <20150320153357.GT31346@atomide.com>
 <87bnjnfz1t.fsf@kamboji.qca.qualcomm.com>
Message-ID: <20150320162138.GU31346@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kalle Valo <kvalo@codeaurora.org> [150320 08:51]:
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Kalle Valo <kvalo@codeaurora.org> [150319 23:04]:
> >> Tony Lindgren <tony@atomide.com> writes:
> >> 
> >> >> > Tested OK (boot, scan, join, ping) on Pandaboard ES.
> >> >> >
> >> >> thanks for testing it!
> >> >
> >> > Great. As suggested by Kalle, I'll apply all these into
> >> > omap-for-v4.1/wl12xx branch and send a pull request for
> >> > the arm-soc probably on Friday if no issues are found.
> >> 
> >> Great, thank you. Just in case you want this:
> >> 
> >> Acked-by: Kalle Valo <kvalo@codeaurora.org>
> >
> > Thanks, I can push out a new branch omap-for-v4.1/wl12xx-v2
> > with your acks assuming you or somebody else have not
> > merged the existing omap-for-v4.1/wl12xx branch yet into the
> > wireless tree?
> >
> > In that case I can scrap omap-for-v4.1/wl12xx and then will
> > reply with a commit that we can consider immutable that can
> > be merged into various trees as needed in case of merge
> > conflicts.
> >
> > But I'll wait for your confirmation first :)
> 
> After John "retired" we actually have two set of trees now: mac80211
> maintained by Johannes and wireless-drivers maintained by me. I haven't
> pulled anything from your tree and I'm 100% sure Johannes hasn't either.
> So green light from me.

OK, I'll set up the new branch then. I take your ack is for the
whole series? If it's just for the $subject patch, please let
me know.

Regards,

Tony
