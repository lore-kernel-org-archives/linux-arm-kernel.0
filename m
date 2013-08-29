From: olof@lixom.net (Olof Johansson)
Date: Thu, 29 Aug 2013 16:20:11 -0700
Subject: [PATCH v3 3/5] ARM: bcm4760: Add system timer
In-Reply-To: <20130814221237.695587612@gmail.com>
References: <20130814221043.528864175@gmail.com>
 <20130814221237.695587612@gmail.com>
Message-ID: <20130829232011.GB29606@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 15, 2013 at 12:10:46AM +0200, Domenico Andreoli wrote:
> From: Domenico Andreoli <domenico.andreoli@linux.com>
> 
> System timer implementation for the BCM4760 based SoCs.
> 
> v3:
> * unchanged
> 
> v2:
> * dropped clock-frequency property, its allowed value was anyway fixed
>   to 24MHz and not clearly related to any known clock
> 
> v1:
> * initial release
> 
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>

Acked-by: Olof Johansson <olof@lixom.net>
