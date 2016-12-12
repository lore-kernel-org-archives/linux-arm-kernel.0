From: robh@kernel.org (Rob Herring)
Date: Mon, 12 Dec 2016 13:28:09 -0600
Subject: [PATCH v6 5/8] IIO: add bindings for STM32 timer trigger driver
In-Reply-To: <1481292919-26587-6-git-send-email-benjamin.gaignard@st.com>
References: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
 <1481292919-26587-6-git-send-email-benjamin.gaignard@st.com>
Message-ID: <20161212192809.hwcq2owmybacsqke@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 03:15:16PM +0100, Benjamin Gaignard wrote:
> Define bindings for STM32 timer trigger
> 
> version 4:
> - remove triggers enumeration from DT
> - add reg parameter
> 
> version 3:
> - change file name
> - add cross reference with mfd bindings
> 
> version 2:
> - only keep one compatible
> - add DT parameters to set lists of the triggers:
>   one list describe the triggers created by the device
>   another one give the triggers accepted by the device
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../bindings/iio/timer/stm32-timer-trigger.txt     | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt

Other than same comments I made in the other patches for the example, 
looks fine.

Acked-by: Rob Herring <robh@kernel.org>
