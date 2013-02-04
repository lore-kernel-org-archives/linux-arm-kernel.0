From: will.deacon@arm.com (Will Deacon)
Date: Mon, 4 Feb 2013 14:24:17 +0000
Subject: [PATCH v3 00/15] multi-cluster power management
In-Reply-To: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
References: <1359445870-18925-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <20130204142417.GE28975@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

On Tue, Jan 29, 2013 at 07:50:55AM +0000, Nicolas Pitre wrote:
> This is version 3 of the patch series required to safely power up
> and down CPUs in a cluster as can be found in b.L systems.  Also
> included are the needed patches to allow CPU hotplug on RTSM configured
> for big.LITTLE.

[...]

For patches 1-6 and 8:

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Please keep me posted when you have a crack at removing the compile-time
cluster/cpu limits!

Cheers,

Will
