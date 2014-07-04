From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 4 Jul 2014 13:42:07 +0200
Subject: [PATCH v2 3/4] ARM: sti: Add STiH407 Kconfig entry to select
 STIH407_RESET
In-Reply-To: <1404310129-14667-4-git-send-email-peter.griffin@linaro.org>
References: <1404310129-14667-1-git-send-email-peter.griffin@linaro.org>
 <1404310129-14667-4-git-send-email-peter.griffin@linaro.org>
Message-ID: <53B6930F.50307@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 07/02/2014 04:08 PM, Peter Griffin wrote:
> The STiH407 is a STMicroelectronics Digital Consumer electronics
> family, targetted at set-top-box and other audio/video applications.
>
> This patch selects the reset controller driver for this family which
> is essential to take various IP's on the SoC out of powerdown / reset.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Applied.

Thanks!
Maxime
