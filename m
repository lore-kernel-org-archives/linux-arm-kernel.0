From: briannorris@chromium.org (Brian Norris)
Date: Wed, 14 Dec 2016 19:20:53 -0800
Subject: [PATCH 3/3] arm64: dts: rockchip: add clk-480m for ehci and ohci
 of rk3399
In-Reply-To: <5ce521da-119a-2de8-026c-5992fedfef43@rock-chips.com>
References: <1481710301-1454-1-git-send-email-zhengxing@rock-chips.com>
 <1481710301-1454-4-git-send-email-zhengxing@rock-chips.com>
 <CAD=FV=UU4JdRjRgEvc_wxprvi6bo46+jd=x2m2QzOe4uJmuRPA@mail.gmail.com>
 <5ce521da-119a-2de8-026c-5992fedfef43@rock-chips.com>
Message-ID: <20161215032052.GA116728@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2016 at 10:41:04AM +0800, Xing Zheng wrote:
> // Frank
> 
> Hi Doug,  Brain,
>     Thanks for the reply.
>     Sorry I forgot these patches have been sent earlier, and Frank
> have some explained and discussed with Heiko.
> Please see https://patchwork.kernel.org/patch/9255245/
>     Perhaps we can move to that patch tree to continue the discussion.
> 
>     I think Frank and William will help us to continue checking these.

I only briefly read that discussion, but AFAICT it doesn't actually
address all the comments/quetions we had here. For instance, the
power_off() vs. delayed-work race in your USB2 PHY driver (is that
intentional?). Also, the question of why PHY (auto?)suspend is relevant.

I'll check again tomorrow.

Brian
