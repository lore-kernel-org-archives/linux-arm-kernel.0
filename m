From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 13 Mar 2018 16:08:38 +0100
Subject: [PATCH 18/31] perf vendor events arm64: Add armv8-recommended.json
In-Reply-To: <6c485ee7-87d1-dc51-db34-94169b9ede08@huawei.com>
References: <20180313120508.29327-1-acme@kernel.org>
 <20180313120508.29327-19-acme@kernel.org>
 <20180313142618.36je6syqg6ppwhbp@gmail.com>
 <6c485ee7-87d1-dc51-db34-94169b9ede08@huawei.com>
Message-ID: <20180313150838.j6mfywse64o5ixhd@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* John Garry <john.garry@huawei.com> wrote:

> On 13/03/2018 14:26, Ingo Molnar wrote:
> > 
> > * Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > 
> > > From: John Garry <john.garry@huawei.com>
> > > 
> > > Add JSON for ARMv8 IMPLEMENTATION DEFINED recommended events.
> > > 
> > > The JSON is copied from ARMv8 architecture reference manual, available
> > > here:
> > > 
> > > 	https://static.docs.arm.com/ddi0487/ca/DDI0487C_a_armv8_arm.pdf
> > > 
> > > Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> > > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > > Cc: Andi Kleen <ak@linux.intel.com>
> > > Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> > > Cc: Jiri Olsa <jolsa@redhat.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: William Cohen <wcohen@redhat.com>
> > > Cc: linux-arm-kernel at lists.infradead.org
> > > Cc: linuxarm at huawei.com
> > > Link: http://lkml.kernel.org/r/1520506716-197429-9-git-send-email-john.garry at huawei.com
> > > Signed-off-by: John Garry <john.garry@huawei.com>
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > That's not a valid SOB chain, author != first-Signed-off-by.
> > 
> 
> Right, so my SOB can go first.
> 
> Let me know how to help remedy.

Well, it depends on what role Shaokun Zhang had in the creation of the patch: if 
he co-authored the patch and you finished it then you can add him as:

  Originally-from: Shaokun Zhang <zhangshaokun@hisilicon.com>

or if he tested/reviewed the patch then his entry should be Reviewed-by/Acked-by 
or Tested-by.

Thanks,

	Ingo
