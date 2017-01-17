From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Jan 2017 11:30:49 +0000
Subject: [PATCH v3 1/2] of: base: add support to find the level of the
 last cache
In-Reply-To: <1484563244-14743-1-git-send-email-sudeep.holla@arm.com>
References: <1484563244-14743-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20170117113048.GD27328@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 16, 2017 at 10:40:43AM +0000, Sudeep Holla wrote:
> It is useful to have helper function just to get the number of cache
> levels for a given logical cpu. We can obtain the same by just checking
> the level at which the last cache is present. This patch adds support
> to find the level of the last cache for a given cpu.
> 
> It will be used on ARM64 platform where the device tree provides the
> information for the additional non-architected/transparent/external
> last level caches that are not integrated with the processors.
> 
> Cc: Mark Rutland <mark.rutland@arm.com>
> Suggested-by: Rob Herring <robh+dt@kernel.org>
> Acked-by: Rob Herring <robh+dt@kernel.org>
> Tested-by: Tan Xiaojun <tanxiaojun@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/of/base.c  | 26 ++++++++++++++++++++++++++
>  include/linux/of.h |  1 +
>  2 files changed, 27 insertions(+)

Thanks, I've queued these two for 4.11.

Will
