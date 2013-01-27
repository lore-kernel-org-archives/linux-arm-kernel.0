From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 28 Jan 2013 00:53:48 +0100
Subject: [PATCH 23/26] mfd: ab8500-pwm: Enable support for AB8505 PWMLED
 blink
In-Reply-To: <1358254566-12419-24-git-send-email-lee.jones@linaro.org>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
 <1358254566-12419-24-git-send-email-lee.jones@linaro.org>
Message-ID: <20130127235348.GT1174@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, Jan 15, 2013 at 12:56:03PM +0000, Lee Jones wrote:
> From: Naga Radhesh <naga.radheshy@stericsson.com>
> 
> Enable support for PWM OUT LED blinking for AB8505. Instead of
> having 3 pwm instances from ab8500 core file add it as platform data.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Naga Radhesh <naga.radheshy@stericsson.com>
> Reviewed-by: Arun MURTHY <arun.murthy@stericsson.com>
> Reviewed-by: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
> ---
>  drivers/mfd/ab8500-core.c          |   10 --
>  drivers/misc/ab8500-pwm.c          |  282 ++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/ab8500/pwmleds.h |   20 +++
>  include/linux/mfd/abx500/ab8500.h  |    2 +
>  4 files changed, 304 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/misc/ab8500-pwm.c
This pretty much looks like the already existing and PWM API compliant
drivers/pwm/ab8500-pwm.c. What's the point here ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
