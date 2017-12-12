From: robh@kernel.org (Rob Herring)
Date: Tue, 12 Dec 2017 17:25:50 -0600
Subject: [PATCH 3/6] pinctrl: stm32: Add STM32MP157 MPU support
In-Reply-To: <1512742277-28205-4-git-send-email-ludovic.Barre@st.com>
References: <1512742277-28205-1-git-send-email-ludovic.Barre@st.com>
 <1512742277-28205-4-git-send-email-ludovic.Barre@st.com>
Message-ID: <20171212232550.f3275srnc6dj6ud3@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 08, 2017 at 03:11:14PM +0100, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This driver consists of 2 controllers due to a hole in mapping:
> -1 controller for GPIO bankA to K.
> -1 controller for GPIO bankZ.
> 
> Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com>
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  .../bindings/pinctrl/st,stm32-pinctrl.txt          |    2 +

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/stm32/Kconfig                      |    6 +
>  drivers/pinctrl/stm32/Makefile                     |    1 +
>  drivers/pinctrl/stm32/pinctrl-stm32mp157.c         | 2188 ++++++++++++++++++++
>  4 files changed, 2197 insertions(+)
>  create mode 100644 drivers/pinctrl/stm32/pinctrl-stm32mp157.c
