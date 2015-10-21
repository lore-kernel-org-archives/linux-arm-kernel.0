From: dianders@chromium.org (Doug Anderson)
Date: Tue, 20 Oct 2015 21:25:42 -0700
Subject: [PATCH v1 2/2] ARM: dts: rockchip: Add the OTP gpio pinctrl
In-Reply-To: <1445395380-5365-3-git-send-email-wxt@rock-chips.com>
References: <1445395380-5365-1-git-send-email-wxt@rock-chips.com>
 <1445395380-5365-3-git-send-email-wxt@rock-chips.com>
Message-ID: <CAD=FV=WbnWXD1HCON-VHfqSqtp=GFwbsj+g2G8A159CEaEiFYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Tue, Oct 20, 2015 at 7:43 PM, Caesar Wang <wxt@rock-chips.com> wrote:
> We need the OTP pin is gpio state before resetting the TSADC controller,
> since the tshut polarity will generate a high signal.

It might or might not be "high" depending on polarity, right?  It's
just possible that it could glitch during probe.  Other than that nit,
this seems fine to me.

If it's not too much trouble it'd be nice if you could spin with the
description change.  Otherwise:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
