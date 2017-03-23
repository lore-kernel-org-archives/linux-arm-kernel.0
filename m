From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 23 Mar 2017 10:54:56 +0000
Subject: [PATCH 00/14] arm_pmu: ACPI support
In-Reply-To: <01822423-a46e-842a-e21e-07d4b9af7f1e@riken.jp>
References: <01822423-a46e-842a-e21e-07d4b9af7f1e@riken.jp>
Message-ID: <20170323105456.GB9287@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 11:11:47AM +0900, Itaru Kitayama wrote:
> Hi Mark,

Hi,

> I've tried your branch on Mustang. It does boot, but perf doesn't
> list hardware events.

Can you please dump the dmesg here?

What exactly do you see if you run:

$ perf list

> Are you going to try it out on Mustang as well? In Linaro Colo, the
> FW is 3.06.25.

As mentioned in [1], I tried the patches on an APM Mustang platform, and
PMU events worked as expected. I had a local workaround for an FW bug,
but this shouldn't have affected the PMU.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/493808.html
