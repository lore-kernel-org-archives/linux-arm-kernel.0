From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Thu, 22 Jan 2015 15:40:30 +0100
Subject: [PATCH 2/2] ARM: sti: Provide DT nodes for SBC SSC[0..2]
In-Reply-To: <1421921237-8991-2-git-send-email-lee.jones@linaro.org>
References: <1421921237-8991-1-git-send-email-lee.jones@linaro.org>
 <1421921237-8991-2-git-send-email-lee.jones@linaro.org>
Message-ID: <54C10BDE.9090702@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/22/2015 11:07 AM, Lee Jones wrote:
> The Synchronous Serial Controller is used to provide SPI.
>
> These are the ports which are located on the Stand-By Controller (SBC).
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>   arch/arm/boot/dts/stih407-family.dtsi | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
>
>
Applied,

Thanks
