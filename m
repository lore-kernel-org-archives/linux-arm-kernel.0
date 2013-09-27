From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 27 Sep 2013 10:44:19 +0200
Subject: [PATCH 1/6] cpuidle: calxeda: add support to use PSCI calls
In-Reply-To: <1380248694-13388-2-git-send-email-robherring2@gmail.com>
References: <1380248694-13388-1-git-send-email-robherring2@gmail.com>
 <1380248694-13388-2-git-send-email-robherring2@gmail.com>
Message-ID: <52454563.9000208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2013 04:24 AM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> This updates the Calxeda cpuidle driver to use PSCI calls to powergate
> cores. This is needed to enable cpuidle for the ECX-2000.
>
> This could possibly become a generic PSCI driver, but there are no other
> PSCI users in the kernel other than mach-virt.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm at vger.kernel.org

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
