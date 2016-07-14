From: will.deacon@arm.com (Will Deacon)
Date: Thu, 14 Jul 2016 14:16:03 +0100
Subject: [PATCH v8 0/4] perf: Add APM X-Gene SoC Performance Monitoring
 Unit driver
In-Reply-To: <1468263944-10634-1-git-send-email-ttnguyen@apm.com>
References: <1468263944-10634-1-git-send-email-ttnguyen@apm.com>
Message-ID: <20160714131602.GJ29455@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 12:05:40PM -0700, Tai Nguyen wrote:
> In addition to the X-Gene ARM CPU performance monitoring unit (PMU), there
> are PMU for the SoC system devices such as L3 cache(s), I/O bridge(s),
> memory controller bridges and memory. These PMU devices are loosely
> architected to follow the same model as the PMU for ARM cores.

You might want to add commit messages to patches 1,2 and 4, but then you
can route this via the arm-soc tree.

Will
