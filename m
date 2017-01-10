From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 10 Jan 2017 11:56:54 +0000
Subject: [PATCH 1/2] of: base: add support to get the number of cache
 levels
In-Reply-To: <1484048479-19767-1-git-send-email-sudeep.holla@arm.com>
References: <1484048479-19767-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <bd0ced47-8d29-b6f6-f818-4e6d191ce383@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/01/17 11:41, Sudeep Holla wrote:
> It is useful to have helper function just to get the number of cache
> levels for a given logical cpu. This patch adds the support for the
> same.
> 
> It will be used on ARM64 platform where the device tree provides the
> information for the additional non-architected/transparent/external
> last level caches that are not integrated with the processors.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/of/base.c  | 22 ++++++++++++++++++++++
>  include/linux/of.h |  1 +
>  2 files changed, 23 insertions(+)
> 

I seem to have missed to generate patch after I fixed the build error.
I will send updated version of this patch.

-- 
Regards,
Sudeep
