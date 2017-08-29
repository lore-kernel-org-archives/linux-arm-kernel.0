From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 29 Aug 2017 12:04:43 +0200
Subject: [PATCH V3 6/8] drivers: boot_constraint: Add debugfs support
In-Reply-To: <20170829063616.GB12198@kroah.com>
References: <cover.1501578037.git.viresh.kumar@linaro.org>
 <7a42cfb49a580a07c2045207fe7f1a3cb2096ce3.1501578037.git.viresh.kumar@linaro.org>
 <20170829063616.GB12198@kroah.com>
Message-ID: <20170829100443.GC3101@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29-08-17, 08:36, Greg Kroah-Hartman wrote:
> On Tue, Aug 01, 2017 at 02:53:47PM +0530, Viresh Kumar wrote:
> > This patch adds debugfs support for boot constraints. This is how it
> > looks for a "vmmc-supply" constraint for the MMC device.
> > 
> > $ ls -R /sys/kernel/debug/boot_constraints/
> > /sys/kernel/debug/boot_constraints/:
> > f723d000.dwmmc0
> > 
> > /sys/kernel/debug/boot_constraints/f723d000.dwmmc0:
> > clk-ciu  pm-domain  supply-vmmc  supply-vmmcaux
> > 
> > /sys/kernel/debug/boot_constraints/f723d000.dwmmc0/clk-ciu:
> > 
> > /sys/kernel/debug/boot_constraints/f723d000.dwmmc0/pm-domain:
> > 
> > /sys/kernel/debug/boot_constraints/f723d000.dwmmc0/supply-vmmc:
> > u_volt_max  u_volt_min
> > 
> > /sys/kernel/debug/boot_constraints/f723d000.dwmmc0/supply-vmmcaux:
> > u_volt_max  u_volt_min
> > 
> > Tested-by: Rajendra Nayak <rnayak@codeaurora.org>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Minor debugfs api interaction nits below:

All accepted :)

-- 
viresh
