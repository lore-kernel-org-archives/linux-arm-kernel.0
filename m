From: dianders@chromium.org (Doug Anderson)
Date: Fri, 8 Aug 2014 08:46:00 -0700
Subject: [PATCH v5 4/4] ARM: dts: Enable USB host1(dwc) on rk3288-evb
In-Reply-To: <1407470159-14722-5-git-send-email-kever.yang@rock-chips.com>
References: <1407470159-14722-1-git-send-email-kever.yang@rock-chips.com>
 <1407470159-14722-5-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=Xwo6DLDapqpaVc3G+1Sx_rapwsw=w-to0JHy+E_U+-iw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Thu, Aug 7, 2014 at 8:55 PM, Kever Yang <kever.yang@rock-chips.com> wrote:
> USB host1 port is the host A port nearby the otg port.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
>
> ---
>
> Changes in v5:
> - don't enable otg port for evb
>
> Changes in v4: None
> Changes in v3:
> - Rebase
>
> Changes in v2:
> - evb patch added in version 2
>
>  arch/arm/boot/dts/rk3288-evb.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)

IMHO this series is ready to go in for 3.18.  I'm assuming Heiko will
pick it up once the bindings have landed.

Reviewed-by: Doug Anderson <dianders@chromium.org>
Tested-by: Doug Anderson <dianders@chromium.org>
