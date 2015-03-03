From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 3 Mar 2015 11:53:19 +0100
Subject: [PATCH v2 4/8] mmc: sdhci-st: Add st_mmcss_cconfig function to
 configure mmcss glue registers.
In-Reply-To: <1424956227-18258-5-git-send-email-peter.griffin@linaro.org>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org>
 <1424956227-18258-5-git-send-email-peter.griffin@linaro.org>
Message-ID: <54F5929F.80503@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 02/26/2015 02:10 PM, Peter Griffin wrote:
> STiH407 family SoC's have glue registers in the flashSS subsystem which
> are used to configure the Arasan HC. This patch configures these glue
> registers according to what has been specified in the DT.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>   drivers/mmc/host/sdhci-st.c | 88 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 88 insertions(+)
>

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime
