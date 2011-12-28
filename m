From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 28 Dec 2011 11:31:29 +0800
Subject: [PATCH V5 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <20111228031409.GL15863@b20223-02.ap.freescale.net>
References: <1324974262-30963-1-git-send-email-richard.zhao@linaro.org>
 <1324974262-30963-5-git-send-email-richard.zhao@linaro.org>
 <20111228031409.GL15863@b20223-02.ap.freescale.net>
Message-ID: <20111228033128.GM15863@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 28, 2011 at 11:14:10AM +0800, Richard Zhao wrote:
> Hi Mark,
> 
> [...]
> > +		if (cpu_reg) {
> > +			ret = regulator_is_supported_voltage(cpu_reg,
> > +					cpu_volts[i * 2], cpu_volts[i * 2 + 1]);
> Is there any reason you didn't export symbol regulator_is_supported_voltage?
> and also it don't have !REGULATOR dummy implementation.
regulator_set_voltage_time and some other functions don't have dummy one
either.
>  
> Thanks
> Richard
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
