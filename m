From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 29 Sep 2015 10:20:47 +0100
Subject: [STLinux Kernel] [PATCH v2 0/7] hwrng: Add support for
 STMicroelectronics' RNG IP
In-Reply-To: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
References: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20150929092047.GA16955@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Thu, 17 Sep 2015, Lee Jones wrote:

> v1 => v2:
>  - New patch: Also fixing /dev/hw_random => /dev/hwrng in Kconfig
>  - Fix 2099 => 2009 typo in commit log
>  - Fix 'number of random numbers sourced' return value
>  - Treat devm_clk_get()'s return value correctly
>  - Check return value of clk_prepare_enable()
>  - Use sysfs_streq() instead of manually stripping '\n' from sysfs
> 
> The main aim of this set is to allow users to access ST's hardware
> random number generator.  It's a simple device, which only requires
> a simple driver.
> 
> We're also taking the liberty to update some out of date HWRNG
> documentation and making the sysfs interface a little easier to
> use by ignoring any '\n' which may have been inadvertently passed.

Looks good, for the series: -

Acked-by: Peter Griffin <peter.griffin@linaro.org>

regards,

Peter.
