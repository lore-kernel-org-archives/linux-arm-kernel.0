From: dianders@chromium.org (Doug Anderson)
Date: Wed, 2 Sep 2015 16:35:28 -0700
Subject: [PATCH v2 2/2] ARM: dts: rockchip: Remove specific cts pullup
 from veyron
In-Reply-To: <1441236479-4941-3-git-send-email-amstan@chromium.org>
References: <1441236479-4941-1-git-send-email-amstan@chromium.org>
 <1441236479-4941-3-git-send-email-amstan@chromium.org>
Message-ID: <CAD=FV=UQz3ip3q4Kt8_HJrG800a9gzJDiaqoi6=JPBxO=6A80A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex,

On Wed, Sep 2, 2015 at 4:27 PM, Alexandru M Stan <amstan@chromium.org> wrote:
> With the previous patch ("rk3288: pull up cts lines") this is redundant,
> I sent that patch for the same reason this existed here, so the lines don't
> wiggle randomly when disconnected.
>
> Signed-off-by: Alexandru M Stan <amstan@chromium.org>
> ---
> Changes in v2:
> - Restrict changes only to cts pin, leave rts alone
> - CC people with the firefly board
> - New patch removing redundant pullup code from veyron
> - cover letter
>
>  arch/arm/boot/dts/rk3288-veyron.dtsi | 12 ------------
>  1 file changed, 12 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
