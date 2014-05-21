From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 21 May 2014 13:26:06 +0200
Subject: [PATCH v2 2/3] ARM: sti: stih416: Enable board LED support for
 B2020 RevE
In-Reply-To: <1400661924-10745-2-git-send-email-lee.jones@linaro.org>
References: <1400661924-10745-1-git-send-email-lee.jones@linaro.org>
 <1400661924-10745-2-git-send-email-lee.jones@linaro.org>
Message-ID: <537C8D4E.3000405@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/21/2014 10:45 AM, Lee Jones wrote:
> There are two LEDs available on the B2020 RevE board, one red, one
> green.  In this patch we enable the red one for "heartbeat" and turn
> the green one off.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   arch/arm/boot/dts/stih416-b2020-revE.dts | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
>

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime


[...]
