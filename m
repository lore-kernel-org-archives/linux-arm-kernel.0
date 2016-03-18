From: sgurrappadi@nvidia.com (Sai Gurrappadi)
Date: Fri, 18 Mar 2016 10:49:18 -0700
Subject: [PATCH v4 2/8] Documentation: arm: define DT cpu capacity bindings
In-Reply-To: <1458311054-13524-3-git-send-email-juri.lelli@arm.com>
References: <1458311054-13524-1-git-send-email-juri.lelli@arm.com>
 <1458311054-13524-3-git-send-email-juri.lelli@arm.com>
Message-ID: <56EC3F9E.4050209@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Juri,

On 03/18/2016 07:24 AM, Juri Lelli wrote:

<snip>

> +
> +==========================================
> +2 - CPU capacity definition
> +==========================================
> +
> +CPU capacity is a number that provides the scheduler information about CPUs
> +heterogeneity. Such heterogeneity can come from micro-architectural differences
> +(e.g., ARM big.LITTLE systems) or maximum frequency at which CPUs can run
> +(e.g., SMP systems with multiple frequency domains). Heterogeneity in this
> +context is about differing performance characteristics; this binding tries to
> +capture a first-order approximation of the relative performance of CPUs.

Any reason why this capacity number is not dynamically generated based on the
max frequency for each CPU? The DT property would then instead specify just
the micro-architectural differences between the CPU types.

-Sai
