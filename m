From: jcm@redhat.com (Jon Masters)
Date: Fri, 12 Sep 2014 15:48:23 -0400
Subject: [PATCH v4 14/18] ARM64 / ACPI: Add GICv2 specific ACPI boot
 support
In-Reply-To: <1410530416-30200-15-git-send-email-hanjun.guo@linaro.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-15-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54134E07.6010508@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2014 10:00 AM, Hanjun Guo wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> 
> ACPI kernel uses MADT table for proper GIC initialization. It needs to
> parse GIC related subtables, collect CPU interface and distributor
> addresses and call driver initialization function (which is hardware
> abstraction agnostic). In a similar way, FDT initialize GICv1/2.
> 
> NOTE: This commit allow to initialize GICv1/2 basic functionality.
> GICv2 vitalization extension, GICv3/4 and ITS are considered as next
> steps.

Aside: A request to specifically update the flags in ACPI to indicate
GICv3/v4 systems has been filed for a future spec revision.

Jon.
