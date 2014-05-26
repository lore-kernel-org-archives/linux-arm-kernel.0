From: gdjakov@mm-sol.com (Georgi Djakov)
Date: Mon, 26 May 2014 16:47:28 +0300
Subject: [GIT PULL] qcom SoC changes for v3.16
In-Reply-To: <1401108595.6068.5.camel@x220>
References: <alpine.DEB.2.00.1405231339340.15680@galak-ubuntu.qualcomm.com>
 <1401108595.6068.5.camel@x220>
Message-ID: <538345F0.40605@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/26/2014 03:49 PM, Paul Bolle wrote:
> On Fri, 2014-05-23 at 13:42 -0500, Kumar Gala wrote:
>> Ivan T. Ivanov (1):
>>         ARM: debug: qcom: make UART address selection configuration option
>
> This one just landed in linux-next (next-20140526).
>
> It removed the Kconfig options DEBUG_MSM_UART1, DEBUG_MSM_UART3, and
> DEBUG_MSM_UART3. It did not touch these references to their macros:
>      arch/arm/mach-msm/io.c:60:#if defined(CONFIG_DEBUG_MSM_UART1) || defined(CONFIG_DEBUG_MSM_UART2) || \
>      arch/arm/mach-msm/io.c:61:                defined(CONFIG_DEBUG_MSM_UART3)
>      arch/arm/mach-msm/io.c:79:#if defined(CONFIG_DEBUG_MSM_UART1) || defined(CONFIG_DEBUG_MSM_UART2) || \
>      arch/arm/mach-msm/io.c:80:                defined(CONFIG_DEBUG_MSM_UART3)
>
> Is a patch to fix this queued somewhere?
>

Not yet, but I'll send one in a minute.

Thanks,
Georgi
