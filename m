From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Mar 2014 09:39:18 +0000
Subject: [PATCH v4 4/6] pinctrl: st: Use ARRAY_SIZE instead of raw value
 for number of delays
In-Reply-To: <1394614210-15698-5-git-send-email-maxime.coquelin@st.com>
References: <1394614210-15698-1-git-send-email-maxime.coquelin@st.com>
 <1394614210-15698-5-git-send-email-maxime.coquelin@st.com>
Message-ID: <20140312093918.GF5672@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch replaces the raw values with ARRAY_SIZE for assigning the
> ninput_delays and noutput_delays fields of STiH416's st_pctl_data struct.
> 
> CC: Lee Jones <lee.jones@linaro.org>
> Acked-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
>  drivers/pinctrl/pinctrl-st.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
