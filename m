From: horms@verge.net.au (Simon Horman)
Date: Wed, 5 Apr 2017 14:17:55 -0400
Subject: [PATCH 0/3] arm: dts: renesas: Drop _clk suffix from clock node
 names
In-Reply-To: <CAMuHMdWSLKjcyQP25mPCwn8EV1xzAyC=AipT8E0DbeVoEeemAw@mail.gmail.com>
References: <1491214089-14093-1-git-send-email-geert+renesas@glider.be>
 <20170405013815.GK18246@codeaurora.org>
 <CAMuHMdWSLKjcyQP25mPCwn8EV1xzAyC=AipT8E0DbeVoEeemAw@mail.gmail.com>
Message-ID: <20170405181755.GA31226@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 09:09:20AM +0200, Geert Uytterhoeven wrote:
> Hi Stephen,
> 
> On Wed, Apr 5, 2017 at 3:38 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 04/03, Geert Uytterhoeven wrote:
> >> The current practice is to not add _clk suffixes to clock node names in
> >> DT, as these names are used as the actual clock names.
> >>
> >> This patch removes the remaining offenders in the various Renesas DTSes.
> >
> > This changes the names in the clk framework too though? If you're
> > ok with that I'm ok too.
> 
> Yes, that's my main motivation doing this: it's a bit silly to have some clocks
> show up in /sys/kernel/debug/clk/clk_summary with a "_clk" suffix.
> 
> > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> 
> Thanks!

Thanks, I have queued these up.
