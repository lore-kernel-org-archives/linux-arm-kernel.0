From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Mar 2017 14:12:22 +0000
Subject: [PATCH v6 04/11] Documentation: perf: hisi: Documentation for
 HiP05/06/07 PMU event counting.
In-Reply-To: <1489127259-112648-1-git-send-email-anurup.m@huawei.com>
References: <1489127259-112648-1-git-send-email-anurup.m@huawei.com>
Message-ID: <20170321141222.GE22188@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Mar 10, 2017 at 01:27:39AM -0500, Anurup M wrote:

> +HiP0x chips are encapsulated by multiple CPU and IO die's. The CPU die is

Nit: that apostrophe shouldn't be there.

[...]

> +The current driver doesnot support sampling. so "perf record" is unsupported.

Nit: spacing

Otherwise, this looked fine.

Thanks,
Mark.
