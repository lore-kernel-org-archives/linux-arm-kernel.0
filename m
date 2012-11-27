From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 27 Nov 2012 20:04:44 +0100
Subject: [PATCH 0/6 v5] cpufreq: add support for Calxeda ECX-1000
 (highbank)
In-Reply-To: <1354028674-23685-1-git-send-email-mark.langsdorf@calxeda.com>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com>
 <1354028674-23685-1-git-send-email-mark.langsdorf@calxeda.com>
Message-ID: <3361516.Nl27KtHLfN@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, November 27, 2012 09:04:28 AM Mark Langsdorf wrote:
> This patch series adds cpufreq support for the Calxeda
> ECX-1000 (highbank) SoCs. The driver is based on the 
> cpufreq-cpu0 driver. Because of the unique way that 
> highbank uses the EnergyCore Management Engine to manage
> voltages, it was not possible to use the cpufreq-cpu0 driver.

Well, Thomas still seems to be unhappy with [4/6], although those don't seem
to be essential points.

Can you please address his comments?

I can't promise I'll take it to my first pull request during the upcoming merge
window, but it looks like there will be a second one anyway.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
