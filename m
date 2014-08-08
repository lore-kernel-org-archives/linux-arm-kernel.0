From: dianders@chromium.org (Doug Anderson)
Date: Fri, 8 Aug 2014 08:45:16 -0700
Subject: [PATCH v5 3/4] ARM: dts: add rk3288 dwc2 controller support
In-Reply-To: <1407470159-14722-4-git-send-email-kever.yang@rock-chips.com>
References: <1407470159-14722-1-git-send-email-kever.yang@rock-chips.com>
 <1407470159-14722-4-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=XNSp85H2zVrLPdxDfhokEWFspvwUHjVMWRu8k_wFFm0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Thu, Aug 7, 2014 at 8:55 PM, Kever Yang <kever.yang@rock-chips.com> wrote:
> rk3288 has two kind of usb controller, this add the dwc2 controller
> for otg and host1.
>
> Controller can works with usb PHY default setting and Vbus on.
>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> Tested-by: Doug Anderson <dianders@chromium.org>
> ---
>
> Changes in v5:
> - change the sort order of dwc2 in rk3288.dtsi
>
> Changes in v4: None
> Changes in v3:
> - EHCI and HSIC move new for version 3.
>
> Changes in v2: None
>
>  arch/arm/boot/dts/rk3288.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

IMHO this series is ready to go in for 3.18.  I'm assuming Heiko will
pick it up once the bindings have landed.  It already has my tags.  ;)
