From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 28 Dec 2011 11:14:10 +0800
Subject: [PATCH V5 4/7] cpufreq: add clk-reg cpufreq driver
In-Reply-To: <1324974262-30963-5-git-send-email-richard.zhao@linaro.org>
References: <1324974262-30963-1-git-send-email-richard.zhao@linaro.org>
 <1324974262-30963-5-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111228031409.GL15863@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

[...]
> +		if (cpu_reg) {
> +			ret = regulator_is_supported_voltage(cpu_reg,
> +					cpu_volts[i * 2], cpu_volts[i * 2 + 1]);
Is there any reason you didn't export symbol regulator_is_supported_voltage?
and also it don't have !REGULATOR dummy implementation.
 
Thanks
Richard
