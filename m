From: robh@kernel.org (Rob Herring)
Date: Mon, 9 Jan 2017 11:59:39 -0600
Subject: [PATCH v7 1/8] MFD: add bindings for STM32 Timers driver
In-Reply-To: <1483608344-9012-2-git-send-email-benjamin.gaignard@st.com>
References: <1483608344-9012-1-git-send-email-benjamin.gaignard@st.com>
 <1483608344-9012-2-git-send-email-benjamin.gaignard@st.com>
Message-ID: <20170109175939.3wpidwkktfxo3x5t@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 10:25:37AM +0100, Benjamin Gaignard wrote:
> Add bindings information for STM32 Timers
> 
> version 6:
> - rename stm32-gtimer to stm32-timers
> - change compatible
> - add description about the IPs
> 
> version 2:
> - rename stm32-mfd-timer to stm32-gptimer
> - only keep one compatible string
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/mfd/stm32-timers.txt       | 46 ++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/stm32-timers.txt

Acked-by: Rob Herring <robh@kernel.org>
