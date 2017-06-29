From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 29 Jun 2017 09:41:10 +0530
Subject: [RFC 4/5] drivers: boot_constraint: Add debugfs support
In-Reply-To: <ac877900-52bb-fc97-12cf-3f6099090623@infradead.org>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
 <58dbcc2e397fc679af814a9752efa1829885d7f3.1498642745.git.viresh.kumar@linaro.org>
 <ac877900-52bb-fc97-12cf-3f6099090623@infradead.org>
Message-ID: <20170629041110.GH29665@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28-06-17, 08:46, Randy Dunlap wrote:
> On 06/28/2017 03:26 AM, Viresh Kumar wrote:
> > This patch adds debugfs support for boot constraints. This is how it
> > looks for a "vmmc-supply" constraint for the MMC device.
> > 
> 
> Hi,
> Does this build OK when DEBUG_FS is not enabled in kernel .config?

TBH, I haven't tried this earlier as I believed dummy implementation
of all the debugfs helpers is available.

It needs the following debugfs patch (that I sent just now), which
adds the dummy implementation of debugfs_create_ulong().

https://marc.info/?l=linux-kernel&m=149870936319587

-- 
viresh
