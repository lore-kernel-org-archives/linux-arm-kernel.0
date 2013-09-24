From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 24 Sep 2013 15:58:06 +0200
Subject: [PATCH v5 1/3] clk: samsung: Add clock driver for s5pc110/s5pv210
In-Reply-To: <1380027009-2239-2-git-send-email-m.krawczuk@partner.samsung.com>
References: <1380027009-2239-1-git-send-email-m.krawczuk@partner.samsung.com>
 <1380027009-2239-2-git-send-email-m.krawczuk@partner.samsung.com>
Message-ID: <52419A6E.9020203@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 24/09/13 14:50, Mateusz Krawczuk wrote:
> +++ b/Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.txt
> @@ -0,0 +1,75 @@
> +* Samsung S5PC110/S5PV210 Clock Controller
> +
> +The S5PV210 clock controller generates and supplies clock to various controllers
> +within the SoC. The clock binding described here is applicable to all SoCs in
> +the S5PC110/S5PV210 family.
> +
> +Required Properties:
> +
> +- compatible: should be "samsung,s5pv210-clock".

I have nothing against this compatible value, but wouldn't it be more
accurate to use, e.g. "samsung,s5pv210-cmu" - for Clock Management Unit,
as this IP block is also referred to in the documentation ?

May just be me, but "samsung,s5pv210-clock" sounds like just one
specific clock type.

--
Thanks,
Sylwester
