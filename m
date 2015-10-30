From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 30 Oct 2015 09:51:08 +0100
Subject: [PATCH 3/7] clocksource/drivers/st_lpc: Fix Kconfig dependency
In-Reply-To: <1446159166-20384-3-git-send-email-daniel.lezcano@linaro.org>
References: <1446159166-20384-1-git-send-email-daniel.lezcano@linaro.org>
 <1446159166-20384-3-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <56332F7C.1000805@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 10/29/2015 11:52 PM, Daniel Lezcano wrote:
> Change the Kconfig selection rule by letting the STI arch to select
> the timer.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>   arch/arm/mach-sti/Kconfig   | 1 +
>   drivers/clocksource/Kconfig | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)
>
>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
