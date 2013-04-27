From: dianders@chromium.org (Doug Anderson)
Date: Sat, 27 Apr 2013 15:31:02 -0700
Subject: [PATCH v2] ARM: exynos: dts: cros5250: add EC device
In-Reply-To: <20130427221410.GA10618@quad.lixom.net>
References: <1367019745-31826-1-git-send-email-olof@lixom.net>
 <20130427221410.GA10618@quad.lixom.net>
Message-ID: <CAD=FV=U8889MZVdSxxYtYfVF3bY67URG9anxR1aU2oyLOHwKNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

On Sat, Apr 27, 2013 at 3:14 PM, Olof Johansson <olof@lixom.net> wrote:
> Add basic EC information to device tree, currently only describing the
> keyboard and keymap.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>
> This builds on the previous patch from Doug to add arbitration (and the
> sbs-battery dts patch).
>
>  arch/arm/boot/dts/exynos5250-snow.dts | 96 +++++++++++++++++++++++++++++++++++
>  1 file changed, 96 insertions(+)

Looks good to me.  Thanks!

Reviewed-by: Doug Anderson <dianders@chromium.org>
