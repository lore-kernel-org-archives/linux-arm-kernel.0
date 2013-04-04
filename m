From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 4 Apr 2013 11:05:39 +0100
Subject: [PATCH 1/2] mfd: db8500-prcmu: Return early if the TCPM cannot
 be located
In-Reply-To: <1365067877-29459-1-git-send-email-lee.jones@linaro.org>
References: <1365067877-29459-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20130404100539.GA8921@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 04 Apr 2013, Lee Jones wrote:

> Currently we check to see if we obtained the Tightly Coupled Program
> Memory (TCPM) base and only execute the code within the check if we
> have it. It's more traditional to return early if we don't have it.
> This way we can flatten most of the function's code down to a single
> tab spacing.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/mfd/db8500-prcmu.c |   40 +++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)

Withdrawn.

I'll resubmit.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
