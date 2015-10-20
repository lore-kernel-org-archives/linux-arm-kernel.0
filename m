From: dianders@chromium.org (Doug Anderson)
Date: Tue, 20 Oct 2015 09:01:38 -0700
Subject: [PATCH 3/4] thermal: rockchip: change the TSHUT default state
In-Reply-To: <1445332264-6054-4-git-send-email-wxt@rock-chips.com>
References: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
 <1445332264-6054-4-git-send-email-wxt@rock-chips.com>
Message-ID: <CAD=FV=Vo1Wf6opTc5jQjm-nXd=BCJxeggipPj4ER9Ehutxs_6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Tue, Oct 20, 2015 at 2:11 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> As the TRM says, the TSHUT default state is high active.
> In general, the TSHUT state can get from the dts. Otherwise
> it gets the state from this.

Can you point at where the TRM says that the default state is high active?

With the manual I have, I look at TSADC_AUTO_CON and I look at the
description of "Bit 8".  It says that "tshut polarity" is 0 for low
active and 1 for high active.  It then said that the Reset Value is 0.

...the "Reset Value" in tables like this is notoriously unreliable, so
I can totally believe that it's wrong.  If you can point me at the
part of the TRM that says that TSHUT is high active by default then I
can confirm that for you.  ;)


-Doug
