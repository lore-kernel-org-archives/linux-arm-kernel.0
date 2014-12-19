From: dianders@chromium.org (Doug Anderson)
Date: Thu, 18 Dec 2014 16:21:49 -0800
Subject: [PATCH 3/3] ARM: dts: rk3288: Add drive/sample clocks for dw_mmc
 devices
In-Reply-To: <1418943663-10012-4-git-send-email-amstan@chromium.org>
References: <1418943663-10012-1-git-send-email-amstan@chromium.org>
 <1418943663-10012-4-git-send-email-amstan@chromium.org>
Message-ID: <CAD=FV=XVGCENbiiQS=Zhd2iQ7UuHPbq_f8RfEcWA9qrZRLGfGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex,

On Thu, Dec 18, 2014 at 3:01 PM, Alexandru M Stan <amstan@chromium.org> wrote:
> The drive/sample clocks can be phase shifted.  The drive clock
> could be used in a future patch to adjust hold times.  The sample
> clock is used for tuning.
>
> Signed-off-by: Alexandru M Stan <amstan@chromium.org>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Suggested-by: Heiko Stuebner <heiko@sntech.de>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> ---
>  arch/arm/boot/dts/rk3288.dtsi | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

I'm not sure I really need a sign-off-by for this since I don't think
I did much besides reupload it once or something.  You can add my
reviewed by instead:

Reviewed-by: Doug Anderson <dianders@chromium.org>
