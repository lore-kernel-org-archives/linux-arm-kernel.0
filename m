From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 Jan 2017 17:43:11 +0000
Subject: [PATCH v3 00/10] perf: arm64: Support for Hisilicon SoC Hardware
 event counters
In-Reply-To: <1483339672-23778-1-git-send-email-anurup.m@huawei.com>
References: <1483339672-23778-1-git-send-email-anurup.m@huawei.com>
Message-ID: <20170110174311.GB24036@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 02, 2017 at 01:47:52AM -0500, Anurup M wrote:
> ToDo:
> 1) The counter overflow handling is currently unsupported in this
>    patch series.

>From a quick scan of the patches, I see mention of an interrupt in a
comment the driver, but there's noething in the DT binding.

Is there an overflow interrupt at all?

Or do you need to implement polling to avoid overflow?

This is a prerequisite for merging the driver.

Thanks,
Mark.
