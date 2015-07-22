From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 22 Jul 2015 11:17:37 +0200
Subject: [PATCH] ARM: STi: Remove platform call to trace_hardirqs_off()
In-Reply-To: <1433886427-29295-1-git-send-email-peter.griffin@linaro.org>
References: <1433886427-29295-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <55AF5FB1.50900@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Peter,

On 06/09/2015 11:47 PM, Peter Griffin wrote:
> Calling trace_hardirqs_off() from the platform specific
> secondary startup code as not been necessary since Dec 2010
> when Russell King consolidated the call into the common SMP
> code.
>
> 2c0136d ARM: SMP: consolidate trace_hardirqs_off() into common SMP code
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>   arch/arm/mach-sti/platsmp.c | 2 --
>   1 file changed, 2 deletions(-)
>

Applied to sti-soc-for-v4.3.

Thanks!
Maxime
