From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 19 Jan 2012 10:25:21 +0100
Subject: [PATCH 0/4] at91 : cleanup pm.h
In-Reply-To: <1326843620-13148-1-git-send-email-daniel.lezcano@linaro.org>
References: <1326843620-13148-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <4F17E181.9090606@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2012 12:40 AM, Daniel Lezcano :
> This patchset makes some cleanup and fix the rm9200 code by replacing
> the standby routine by a asm routine where we have a better control.
> 
> This patchset has been tested on a sam9263, compiled on the other
> platform but not tested because I don't have the hardware. 
> 
> This is my first attempt for an asm arm routine ...
> 
> Daniel Lezcano (4):
>   at91 : coding style fixes
>   at91 : declare header name
>   at91 : remove wait_for_interrupt definition
>   at91 : implement the standby function for pm/cpuidle
> 
>  arch/arm/mach-at91/cpuidle.c |   11 +----
>  arch/arm/mach-at91/pm.c      |   12 +-----
>  arch/arm/mach-at91/pm.h      |   86 +++++++++++++++++++++++++++---------------
>  3 files changed, 59 insertions(+), 50 deletions(-)

Daniel,

You can add my:

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

to the whole patch series. Thanks for your work (and I am looking
forward for your future improvements ;-)).

Best regards,
-- 
Nicolas Ferre
