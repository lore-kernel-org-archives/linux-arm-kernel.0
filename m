From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Tue, 27 Feb 2018 14:25:34 +0100
Subject: [PATCH v3 00/14] Add MMCI support for STM32F SoCs family
In-Reply-To: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
References: <1516286070-24927-1-git-send-email-patrice.chotard@st.com>
Message-ID: <c4f78733-2544-6cef-97e5-fedcc23de404@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrice,

On 01/18/2018 03:34 PM, patrice.chotard at st.com wrote:
> From: Patrice Chotard <patrice.chotard@st.com>
> 
> This series reworks patches submitted one year ago by Andrea Merello [1]
> but without succeed to merged it.
> 
> STM32F4 and STM32F7 SoCs families embeds a variant of the ARM PrimeCell
> PL18x SD host controller, for which the mmci driver exists.
> This series adds support for these SoCs to the mmci driver.
> 
> As other variants, this one need some specific quirks, that this
> series address.
> 
> This series has been tested on following boards :
> 	_ stm32f429-eval
> 	_ stm32f469-disco
> 	_ stm32f746-eval
> 	_ stm32f769-disco
> 
> DT update for stm32f7 pinctrl, stm32f746-eval and stm32f769-disco boards
> will be sent later to avoid conflict with pending stm32f7 series [1] which
> is not yet merged on kernel mainline.
> 
> [1] https://www.spinics.net/lists/linux-mmc/msg41616.html
> [2] https://patchwork.kernel.org/patch/10104447/
>
...

Patches 6 to 13 (DT/SoC/configs) applied on stm32-next.

Thanks
Alex
