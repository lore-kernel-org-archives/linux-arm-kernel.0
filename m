From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 30 Apr 2015 13:06:27 +0200
Subject: [PATCH 2/3] ARM: DT: STi: STiH407: Add sata DT nodes.
In-Reply-To: <1427787309-1601-3-git-send-email-peter.griffin@linaro.org>
References: <1427787309-1601-1-git-send-email-peter.griffin@linaro.org>
 <1427787309-1601-3-git-send-email-peter.griffin@linaro.org>
Message-ID: <55420CB3.8040800@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/31/2015 09:35 AM, Peter Griffin wrote:
> Now that the miphy28lp is upstream, we can add the sata dt nodes
> for stih407 family silicon. This has been tested on b2120 board
> J4 (sata0 channel). These nodes are disabled by default as a
> special mini pci-e to sata daughter board is required which
> isn't shipped with the board.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
> ---
>   arch/arm/boot/dts/stih407-family.dtsi | 44 +++++++++++++++++++++++++++++++++++
>   1 file changed, 44 insertions(+)
>
>
Applied in sti-dt-for-v4.2.

Thanks!
Maxime
