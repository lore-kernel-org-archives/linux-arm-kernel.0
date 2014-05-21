From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 21 May 2014 13:25:53 +0200
Subject: [PATCH v2 1/3] ARM: sti: stih416: Add support for B2020 RevE
In-Reply-To: <1400661924-10745-1-git-send-email-lee.jones@linaro.org>
References: <1400661924-10745-1-git-send-email-lee.jones@linaro.org>
Message-ID: <537C8D41.7090403@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05/21/2014 10:45 AM, Lee Jones wrote:
> The B2020 RevE differs from the other B2020 boards in a few subtle ways;
> including the Ethernet reset GPIO which this patch adds support for and
> the LED wiring which will follow in a latter patch.  Without supplying
> these differences Ethernet and the board LEDs simply will not work.
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   arch/arm/boot/dts/Makefile               |  3 ++-
>   arch/arm/boot/dts/stih416-b2020-revE.dts | 21 +++++++++++++++++++++
>   2 files changed, 23 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/boot/dts/stih416-b2020-revE.dts
>


Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime


[...]
