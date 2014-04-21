From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 21 Apr 2014 15:53:29 +0530
Subject: [PATCH v2 3/8] davinci: da850: Use cpufreq_for_each_entry macro
 for iteration
In-Reply-To: <534DB1F9.8020105@semaphore.gr>
References: <534DB1F9.8020105@semaphore.gr>
Message-ID: <5354F1A1.7010200@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 April 2014 03:56 AM, Stratos Karafotis wrote:
> The cpufreq core now supports the cpufreq_for_each_entry macro helper
> for iteration over the cpufreq_frequency_table, so use it.
> 
> It should have no functional changes.
> 
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>

I cannot test this (or even build this) since I do not have the patch
which adds cpufreq_for_each_entry(). The change as such looks fine to
me. Please prefix the subject line with "ARM: " as is the convention in
ARM world.

Thanks,
Sekhar
