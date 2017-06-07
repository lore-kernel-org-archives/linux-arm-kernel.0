From: robh@kernel.org (Rob Herring)
Date: Wed, 7 Jun 2017 16:17:52 -0500
Subject: [PATCH 01/58] ARM: at91: Document new TCB bindings
In-Reply-To: <20170530215139.9983-2-alexandre.belloni@free-electrons.com>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
 <20170530215139.9983-2-alexandre.belloni@free-electrons.com>
Message-ID: <20170607211752.avts3cofvac7ks3q@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 30, 2017 at 11:50:42PM +0200, Alexandre Belloni wrote:
> The current binding for the TCB is not flexible enough for some use cases
> and prevents proper utilization of all the channels.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: linux-pwm at vger.kernel.org
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  .../devicetree/bindings/arm/atmel-at91.txt         | 32 ------------
>  .../devicetree/bindings/mfd/atmel-tcb.txt          | 58 ++++++++++++++++++++++
>  .../devicetree/bindings/pwm/atmel-tcb-pwm.txt      | 12 +++--
>  3 files changed, 65 insertions(+), 37 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt

Acked-by: Rob Herring <robh@kernel.org>
