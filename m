From: robh@kernel.org (Rob Herring)
Date: Thu, 19 Jan 2017 13:31:19 -0600
Subject: [PATCH v8 5/8] IIO: add bindings for STM32 timer trigger driver
In-Reply-To: <1484749251-14445-6-git-send-email-benjamin.gaignard@st.com>
References: <1484749251-14445-1-git-send-email-benjamin.gaignard@st.com>
 <1484749251-14445-6-git-send-email-benjamin.gaignard@st.com>
Message-ID: <20170119193119.kejcwpqrqo735mxh@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 03:20:48PM +0100, Benjamin Gaignard wrote:
> Define bindings for STM32 timer trigger
> 
> version 8:
> - reword "reg" parameter description
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
> Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  .../bindings/iio/timer/stm32-timer-trigger.txt     | 23 ++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/timer/stm32-timer-trigger.txt

Acked-by: Rob Herring <robh@kernel.org>
