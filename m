From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 17 Mar 2014 13:26:50 +0100
Subject: [PATCH] MAINTAINERS: Update ARM STi maintainers
In-Reply-To: <1393846139-18088-1-git-send-email-srinivas.kandagatla@st.com>
References: <1393846139-18088-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <5326EA0A.2030708@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/03/2014 12:28 PM, srinivas.kandagatla at st.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>
> This patch adds Maxime and Patrice to ARM/STi maintainers list.
> As Stuart Menefy opted to be removed from the list, this patch removes
> his email from maintainers. Updated my email with private email address.

This is a gentle reminder.

Srinivas and Stuart ST addresses won't be accessible anymore in a couple 
of weeks.

Maybe the right maintainer is missing in the To list?

Thanks,
Maxime

>
> This patch also adds few more drivers to the list so that get_maintainer
> script can pick the right people to send patch to and avoid email
> bounces.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> CC: Stuart Menefy <stuart.menefy@st.com>
> CC: Maxime Coquelin <maxime.coquelin@st.com>
> CC: Patrice Chotard <patrice.chotard@st.com>
> ---
>   MAINTAINERS |   12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 85b3dd8..0b74b45 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1275,13 +1275,21 @@ S:	Maintained
>   F:	drivers/clk/socfpga/
>
>   ARM/STI ARCHITECTURE
> -M:	Srinivas Kandagatla <srinivas.kandagatla@st.com>
> -M:	Stuart Menefy <stuart.menefy@st.com>
> +M:	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> +M:	Maxime Coquelin <maxime.coquelin@st.com>
> +M:	Patrice Chotard <patrice.chotard@st.com>
>   L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
>   L:	kernel at stlinux.com
>   W:	http://www.stlinux.com
>   S:	Maintained
>   F:	arch/arm/mach-sti/
> +F:	arch/arm/boot/dts/sti*
> +F:	drivers/clocksource/arm_global_timer.c
> +F:	drivers/reset/sti/
> +F:	drivers/pinctrl/pinctrl-st.c
> +F:	drivers/media/rc/st_rc.c
> +F:	drivers/i2c/busses/i2c-st.c
> +F:	drivers/tty/serial/st-asc.c
>
>   ARM/TECHNOLOGIC SYSTEMS TS7250 MACHINE SUPPORT
>   M:	Lennert Buytenhek <kernel@wantstofly.org>
>
