From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 24 May 2016 14:04:21 +0200
Subject: [PATCH v2] pinctrl: stm32: factorize
 stm32_pconf_input/output_get()
In-Reply-To: <1464091063-22341-2-git-send-email-patrice.chotard@st.com>
References: <1464091063-22341-1-git-send-email-patrice.chotard@st.com>
 <1464091063-22341-2-git-send-email-patrice.chotard@st.com>
Message-ID: <57444345.9030107@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/24/2016 01:57 PM, patrice.chotard at st.com wrote:
> From: Patrice Chotard<patrice.chotard@st.com>
>
> As these 2 functions code are 95% similar, factorize them.
>
> Signed-off-by: Patrice Chotard<patrice.chotard@st.com>
> ---
>   drivers/pinctrl/stm32/pinctrl-stm32.c | 31 ++++++++++---------------------
>   1 file changed, 10 insertions(+), 21 deletions(-)

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
