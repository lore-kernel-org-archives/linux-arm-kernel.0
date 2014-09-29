From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 29 Sep 2014 14:23:32 +0200
Subject: [PATCH 3/6] arm/arm64: KVM: add 'writable' parameter to
 kvm_phys_addr_ioremap
In-Reply-To: <54235BC6.2070503@samsung.com>
References: <1410990981-665-1-git-send-email-ard.biesheuvel@linaro.org>
 <1410990981-665-4-git-send-email-ard.biesheuvel@linaro.org>
 <54235BC6.2070503@samsung.com>
Message-ID: <20140929122332.GD3095@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 05:03:18PM -0700, Mario Smarduch wrote:
> Is DEVICE type the correct default, for device
> regions that are prefetchable? The guest might
> want something less restrictive to optimize device
> access.
> 
We don't have a use case for this yet, and we aren't supporting generic
platform device passthrough yet.

So far this patch is solving a real problem, but if we need something
more flexible, then patches are welcome :)

-Christoffer
