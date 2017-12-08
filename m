From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 8 Dec 2017 14:46:34 +0100
Subject: [PATCH v9 4/6] clocksource: stm32: add clocksource support
In-Reply-To: <20171208113250.359-5-benjamin.gaignard@st.com>
References: <20171208113250.359-1-benjamin.gaignard@st.com>
 <20171208113250.359-5-benjamin.gaignard@st.com>
Message-ID: <ac396fdb-1658-d2f3-bd92-b2b9fe04f201@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2017 12:32, Benjamin Gaignard wrote:
> The stm32 timer hardware is currently only used as a clock event device,
> but it can be utilized as a clocksource as well.
> 
> Implement this by enabling the free running counter in the hardware block
> and converting the clock event part from a count down event timer to a
> comparator based timer.


Split this patch in two:
 - periodic support
 - clocksource support




-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
