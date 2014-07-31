From: dianders@chromium.org (Doug Anderson)
Date: Thu, 31 Jul 2014 15:01:51 -0700
Subject: [REPOST PATCH v3 4/5] ARM: dts: Fix the sort ordering of EHCI and
 HSIC in rk3288.dtsi
In-Reply-To: <1406841985-15790-5-git-send-email-kever.yang@rock-chips.com>
References: <1406841985-15790-1-git-send-email-kever.yang@rock-chips.com>
 <1406841985-15790-5-git-send-email-kever.yang@rock-chips.com>
Message-ID: <CAD=FV=U-7D016n08My-SZRjqN68wTW9iuBEMDzkpy+LdTGRdtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kever,

On Thu, Jul 31, 2014 at 2:26 PM, Kever Yang <kever.yang@rock-chips.com> wrote:
> From: Doug Anderson <dianders@chromium.org>
>
> The EHCI and HSIC device tree nodes were added in the wrong place.
> Fix them.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
>
> Changes in v3:
> - EHCI and HSIC move new for version 3.
>
> Changes in v2: None
>
>  arch/arm/boot/dts/rk3288.dtsi |   41 ++++++++++++++++++++---------------------
>  1 file changed, 20 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index a5607a1..673dee3 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -205,6 +205,17 @@
>                 status = "disabled";
>         };
>
> +       usb_host0_ehci: ehci at ff500000 {

Argh.  When I was helping you I messed this up.  :(  I pointed you at
an older version of the EHCI patch.

I'll post a fixup myself.  Sorry for the bother...

-Doug
