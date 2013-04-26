From: dianders@chromium.org (Doug Anderson)
Date: Fri, 26 Apr 2013 16:56:51 -0700
Subject: [PATCH] ARM: exynos: dts: cros5250: add EC device
In-Reply-To: <1367019745-31826-1-git-send-email-olof@lixom.net>
References: <1367019745-31826-1-git-send-email-olof@lixom.net>
Message-ID: <CAD=FV=WhoGO8=5pt=VOCT_2j2CMkn8on=N=jK_2RwMOXWat57w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

On Fri, Apr 26, 2013 at 4:42 PM, Olof Johansson <olof@lixom.net> wrote:
> Add basic EC information to device tree, currently only describing the
> keyboard and keymap.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Doug Anderson <dianders@chromium.org>
> ---
>
> Kukjin, I'll apply this too directly if you don't mind.
>
>
> -Olof
>
>  arch/arm/boot/dts/cros5250-common.dtsi | 99 +++++++++++++++++++++++++++++++++-
>  1 file changed, 98 insertions(+), 1 deletion(-)

I'm not a huge fan of this change as I'd rather see my arbitration
changes land first and see this based atop those.  The arbitration
driver has landed so all that's left are the device tree bits.

That would be:

https://patchwork.kernel.org/patch/2449961/
https://patchwork.kernel.org/patch/2449941/

...but other than that this looks good.

-Doug
