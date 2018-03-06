From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Mar 2018 18:53:30 -0600
Subject: [PATCH 1/2] dt-bindings: serial: stm32: add RS485 optional
 properties
In-Reply-To: <1519815373-22940-2-git-send-email-bich.hemon@st.com>
References: <1519815373-22940-1-git-send-email-bich.hemon@st.com>
 <1519815373-22940-2-git-send-email-bich.hemon@st.com>
Message-ID: <20180306005330.qym4abxbs7x3z27j@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 10:56:18AM +0000, Bich HEMON wrote:
> Add options for enabling RS485 hardware control and configuring
> Driver Enable signal:
> - rs485-rts-delay
> - rs485-rx-during-tx
> - rs485-rts-active-low
> - linux,rs485-enabled-at-boot-time
> 
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> ---
>  Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
