From: dianders@chromium.org (Doug Anderson)
Date: Wed, 21 Oct 2015 06:36:12 -0700
Subject: [PATCH v1 2/2] ARM: dts: rockchip: Add the OTP gpio pinctrl
In-Reply-To: <562717CD.3040601@rock-chips.com>
References: <1445395380-5365-1-git-send-email-wxt@rock-chips.com>
 <1445395380-5365-3-git-send-email-wxt@rock-chips.com>
 <CAD=FV=WbnWXD1HCON-VHfqSqtp=GFwbsj+g2G8A159CEaEiFYQ@mail.gmail.com>
 <562717CD.3040601@rock-chips.com>
Message-ID: <CAD=FV=WN1uuvTakn7qsLgMNGbZgREeNU65==QgS-2AeBuDPN9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Tue, Oct 20, 2015 at 9:42 PM, Caesar Wang <wxt@rock-chips.com> wrote:
> I think the description is right,   maybe need other decriptions.
> The tshut polarity is low in a short period of time when the TSADC
> controller is reset.
>
> In other words,
>
> If T < (setting temperature), the OTP output the High Signal. ------> if the
> otp out polarity is high, the TSHUT will work.
> If T > (setting temperature), the OTP output the Low Signal.

Ah!  I re-read the cover letter more carefully and now I see.  OK, I
think your current description is fine, then.  ;)

-Doug
