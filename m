From: srinivas.kandagatla@st.com (srinivas kandagatla)
Date: Fri, 7 Mar 2014 10:43:30 +0000
Subject: [PATCH v2 2/5] pinctrl: st: add pinctrl support for the STiH407
 SoC
In-Reply-To: <1394185272-26054-3-git-send-email-maxime.coquelin@st.com>
References: <1394185272-26054-1-git-send-email-maxime.coquelin@st.com>
 <1394185272-26054-3-git-send-email-maxime.coquelin@st.com>
Message-ID: <5319A2D2.7090700@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peppe/Maxime,
On 07/03/14 09:41, Maxime COQUELIN wrote:
> From: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> 
> This patch adds the initial support for pinctrl based on H407 SoC.
> 
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>  drivers/pinctrl/pinctrl-st.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
> index 9fb66aa..9e9b6ea 100644
> --- a/drivers/pinctrl/pinctrl-st.c
> +++ b/drivers/pinctrl/pinctrl-st.c
> @@ -1580,6 +1580,10 @@ static struct of_device_id st_pctl_of_match[] = {
>  	{ .compatible = "st,stih416-rear-pinctrl", .data = &stih416_data},
>  	{ .compatible = "st,stih416-fvdp-fe-pinctrl", .data = &stih416_data},
>  	{ .compatible = "st,stih416-fvdp-lite-pinctrl", .data = &stih416_data},
> +	{ .compatible = "st,stih407-sbc-pinctrl", .data = &stih416_data},
> +	{ .compatible = "st,stih407-front-pinctrl", .data = &stih416_data},
> +	{ .compatible = "st,stih407-rear-pinctrl", .data = &stih416_data},
> +	{ .compatible = "st,stih407-flash-pinctrl", .data = &stih416_data},
In the follow on patch this is changed to stih407_flashdata.

Why should this not be done in this patch itself.
>  	{ /* sentinel */ }
>  };
>  
Other than that the patch looks Ok to me.

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Thanks,
srini
> 
