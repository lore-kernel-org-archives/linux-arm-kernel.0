From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 12 Feb 2016 17:00:57 +0000
Subject: [RFC PATCH 0/7] Cavium ThunderX uncore PMU support
In-Reply-To: <cover.1455295032.git.jglauber@cavium.com>
References: <cover.1455295032.git.jglauber@cavium.com>
Message-ID: <20160212170056.GC20262@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 05:55:05PM +0100, Jan Glauber wrote:
> Hi,
> 
> this patch series provides access to various counters on the ThunderX SOC.
> 
> For details of the implementation see patch #1.
> 
> Patches #2-7 add ther various ThunderX specific PMUs.
> 
> I did not want to put these file into arch/arm64/kernel so I added a
> "uncore" directory. Maybe this should be put somewhere under drivers/
> instead.

This is probably better suited to drivers/perf/, or drivers/bus/ (where
CCN and CCI perf drivers live).

Mark.
