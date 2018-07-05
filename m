From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Jul 2018 15:13:00 -0600
Subject: [PATCH v7 07/10] dt-bindings: counter: Document stm32 quadrature
 encoder
In-Reply-To: <c1cc3d567d0a5799c3afe6e24ca9ec3b1547224e.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <c1cc3d567d0a5799c3afe6e24ca9ec3b1547224e.1529607879.git.vilhelm.gray@gmail.com>
Message-ID: <20180705211300.GA18202@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2018 at 05:08:34PM -0400, William Breathitt Gray wrote:
> From: Benjamin Gaignard <benjamin.gaignard@st.com>
> 
> Add bindings for STM32 Timer quadrature encoder.
> It is a sub-node of STM32 Timer which implement the
> quadratic encoder part of the hardware.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  .../bindings/counter/stm32-timer-cnt.txt      | 31 +++++++++++++++++++
>  .../devicetree/bindings/mfd/stm32-timers.txt  |  7 +++++
>  2 files changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/stm32-timer-cnt.txt

Acked-by: Rob Herring <robh@kernel.org> 
