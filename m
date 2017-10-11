From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Oct 2017 13:17:01 +0100
Subject: [PATCH v6 3/4] perf utils: Add helper function is_pmu_core to
 detect PMU CORE devices
In-Reply-To: <20170824120349.2323-4-ganapatrao.kulkarni@cavium.com>
References: <20170824120349.2323-1-ganapatrao.kulkarni@cavium.com>
 <20170824120349.2323-4-ganapatrao.kulkarni@cavium.com>
Message-ID: <20171011121700.GB11106@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 24, 2017 at 05:33:48PM +0530, Ganapatrao Kulkarni wrote:
> On some platforms, PMU core devices sysfs name is not cpu.
> Adding function is_pmu_core to detect PMU core devices using
> core device specific hints in sysfs.
> 
> For arm64 platforms, all core devices have file "cpus" in sysfs.
> 
> Tested-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  tools/perf/util/pmu.c | 39 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 35 insertions(+), 4 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
