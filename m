From: horms@verge.net.au (Simon Horman)
Date: Thu, 5 Oct 2017 11:26:25 +0200
Subject: [PATCH 2/3] ARM: dts: gr-peach: Enable MTU2 timer pulse unit
In-Reply-To: <CAMuHMdV+eXxXE-oa5mQ9h0SQg+a8hMkx+SD0HVzNhKd4sBm1cA@mail.gmail.com>
References: <1507193900-23801-1-git-send-email-jacopo+renesas@jmondi.org>
 <1507193900-23801-3-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdV+eXxXE-oa5mQ9h0SQg+a8hMkx+SD0HVzNhKd4sBm1cA@mail.gmail.com>
Message-ID: <20171005092624.GW26369@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 05, 2017 at 11:02:30AM +0200, Geert Uytterhoeven wrote:
> On Thu, Oct 5, 2017 at 10:58 AM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > MTU2 multi-function/multi-channel timer/counter is not enabled for
> > GR-Peach board. The timer is used as clock event source to schedule
> > wake-ups, and without this enabled all sleeps not performed through busy
> > waiting hang the board.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied.
