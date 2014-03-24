From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 24 Mar 2014 13:36:42 +0000
Subject: [PATCH v2 1/5] drivers: input: keyboard: st-keyscan: add keyscan
 driver
In-Reply-To: <1395154806-2810-2-git-send-email-gabriel.fernandez@st.com>
References: <1395154806-2810-1-git-send-email-gabriel.fernandez@st.com>
 <1395154806-2810-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20140324133642.GB21665@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch adds ST Keyscan driver to use the keypad hw a subset
> of ST boards provide. Specific board setup will be put in the
> given dt.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
> ---
>  .../devicetree/bindings/input/st-keyscan.txt       |  60 +++++
>  drivers/input/keyboard/Kconfig                     |  12 +
>  drivers/input/keyboard/Makefile                    |   1 +
>  drivers/input/keyboard/st-keyscan.c                | 260 +++++++++++++++++++++
>  4 files changed, 333 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/st-keyscan.txt
>  create mode 100644 drivers/input/keyboard/st-keyscan.c

FWIW: This looks good to me now:
  Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
