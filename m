From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Oct 2017 18:32:03 -0500
Subject: [PATCH 1/3] Arm: dts: stm32: remove extra compatible string for
 uart
In-Reply-To: <1506639114-16913-2-git-send-email-vikas.manocha@st.com>
References: <1506639114-16913-1-git-send-email-vikas.manocha@st.com>
 <1506639114-16913-2-git-send-email-vikas.manocha@st.com>
Message-ID: <20171005233203.6o4cs3xzvzlcsr2m@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 28, 2017 at 03:51:24PM -0700, Vikas Manocha wrote:
> This patch removes the extra compatibility string "st,stm32-usart" to
> avoid confusion, save some time & space.

I'm confused why you don't need it anymore. I thought the h/w blocks 
were configured differently.

> 
> Signed-off-by: Vikas Manocha <vikas.manocha@st.com>
> Reviewed-by: Patrice Chotard <patrice.chotard@st.com>
> ---
>  Documentation/devicetree/bindings/dma/stm32-dma.txt         |  2 +-
>  Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 10 +++-------
>  2 files changed, 4 insertions(+), 8 deletions(-)

In any case,

Acked-by: Rob Herring <robh@kernel.org>
