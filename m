From: rdunlap@infradead.org (Randy Dunlap)
Date: Wed, 28 Jun 2017 08:46:31 -0700
Subject: [RFC 4/5] drivers: boot_constraint: Add debugfs support
In-Reply-To: <58dbcc2e397fc679af814a9752efa1829885d7f3.1498642745.git.viresh.kumar@linaro.org>
References: <cover.1498642745.git.viresh.kumar@linaro.org>
 <58dbcc2e397fc679af814a9752efa1829885d7f3.1498642745.git.viresh.kumar@linaro.org>
Message-ID: <ac877900-52bb-fc97-12cf-3f6099090623@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28/2017 03:26 AM, Viresh Kumar wrote:
> This patch adds debugfs support for boot constraints. This is how it
> looks for a "vmmc-supply" constraint for the MMC device.
> 

Hi,
Does this build OK when DEBUG_FS is not enabled in kernel .config?

-- 
~Randy
