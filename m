From: viresh.kumar2@arm.com (viresh kumar)
Date: Fri, 13 Jul 2012 16:27:21 +0100
Subject: [PATCH 3/3] ARM: dts: SPEAr320: Fix no. of supported pinmux mode
In-Reply-To: <37075889880066dd96dc2004ac1116c1c17c70cd.1342181727.git.vipulkumar.samar@st.com>
References: <cover.1342181727.git.vipulkumar.samar@st.com>
 <37075889880066dd96dc2004ac1116c1c17c70cd.1342181727.git.vipulkumar.samar@st.com>
Message-ID: <50003E59.2030707@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/07/12 13:21, Vipul Kumar Samar wrote:
> On spear320 machine no. of supported mode is 4 and by mistake it is programmed
> to 3.
> Supported modes are:
>       AUTO_NET_SMII_MODE
>       AUTO_NET_MII_MODE
>       AUTO_EXP_MODE
>       SMALL_PRINTERS_MODE
>       EXTENDED_MODE

Commit log doesn't tell what you actually wanted to do, i.e. boot the board in EXTENDED mode.

> Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
> ---
>  arch/arm/boot/dts/spear320-evb.dts |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/spear320-evb.dts
> index 4d55b67..c99f055 100644
> --- a/arch/arm/boot/dts/spear320-evb.dts
> +++ b/arch/arm/boot/dts/spear320-evb.dts
> @@ -26,7 +26,7 @@
>
>       ahb {
>               pinmux at b3000000 {
> -                     st,pinmux-mode = <3>;
> +                     st,pinmux-mode = <4>;
>                       pinctrl-names = "default";
>                       pinctrl-0 = <&state_default>;
>
>


--
Viresh

-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
