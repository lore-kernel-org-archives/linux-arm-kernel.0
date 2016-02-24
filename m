From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 24 Feb 2016 17:14:51 +0100
Subject: [PATCH 45/50] pinctrl: st: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-46-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-46-git-send-email-ldewangan@nvidia.com>
Message-ID: <56CDD6FB.5020805@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 02/24/2016 02:16 PM, Laxman Dewangan wrote:
> Use devm_pinctrl_register() for pin control registration.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
> Cc: Maxime Coquelin <maxime.coquelin@st.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: kernel at stlinux.com
> ---
>   drivers/pinctrl/pinctrl-st.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
