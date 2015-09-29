From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 29 Sep 2015 11:42:01 +0100
Subject: [STLinux Kernel] [PATCH v2 0/7] hwrng: Add support for
 STMicroelectronics' RNG IP
In-Reply-To: <20150929092047.GA16955@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
 <20150929092047.GA16955@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20150929104201.GX27197@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 29 Sep 2015, Peter Griffin wrote:
> On Thu, 17 Sep 2015, Lee Jones wrote:
> 
> > v1 => v2:
> >  - New patch: Also fixing /dev/hw_random => /dev/hwrng in Kconfig
> >  - Fix 2099 => 2009 typo in commit log
> >  - Fix 'number of random numbers sourced' return value
> >  - Treat devm_clk_get()'s return value correctly
> >  - Check return value of clk_prepare_enable()
> >  - Use sysfs_streq() instead of manually stripping '\n' from sysfs
> > 
> > The main aim of this set is to allow users to access ST's hardware
> > random number generator.  It's a simple device, which only requires
> > a simple driver.
> > 
> > We're also taking the liberty to update some out of date HWRNG
> > documentation and making the sysfs interface a little easier to
> > use by ignoring any '\n' which may have been inadvertently passed.
> 
> Looks good, for the series: -
> 
> Acked-by: Peter Griffin <peter.griffin@linaro.org>

Thanks, but Herbert already applied the series.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
