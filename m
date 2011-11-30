From: robherring2@gmail.com (Rob Herring)
Date: Wed, 30 Nov 2011 14:40:39 -0600
Subject: [PATCH v2] ARM: pl2x0/pl310: Refactor Kconfig to be more
 maintainable
In-Reply-To: <1322675975-4471-1-git-send-email-dave.martin@linaro.org>
References: <1322675975-4471-1-git-send-email-dave.martin@linaro.org>
Message-ID: <4ED694C7.6020502@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/30/2011 11:59 AM, Dave Martin wrote:
> Making CACHE_L2X0 depends on (huge list of MACH_ and ARCH_ configs)
> is bothersome to maintain and likely to lead to merge conflicts.
> 
> This patch moves the knowledge of which platforms have a L2x0 or
> PL310 cache controller to the individual machines.  To enable this,
> a new HAVE_L2X0_L2CC config option is introduced to allow machines
> to indicate that they have such a cache controller independently of
> each other.
> 
> Signed-off-by: Dave Martin <dave.martin@linaro.org>
> ---
> Changes since v1:
> 
> v2: Add HAVE_L2X0_L2CC instead of CACHE_L2X0 for SOC_IMX6Q.
>     (Thanks to Shawn Guo for suggesting this.)
> 

Did you not see my comments on v1?

Rob
