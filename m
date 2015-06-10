From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 10 Jun 2015 10:09:45 +0200
Subject: [PATCH] ARM: STi: Remove platform call to trace_hardirqs_off()
In-Reply-To: <1433886427-29295-1-git-send-email-peter.griffin@linaro.org>
References: <1433886427-29295-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <5577F0C9.4040701@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter

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
>

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks!
Maxime
