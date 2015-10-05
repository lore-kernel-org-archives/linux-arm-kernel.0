From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 5 Oct 2015 19:25:38 +0200
Subject: [RFT - PATCH v2 0/2] KVM/arm64: add fp/simd lazy switch support
In-Reply-To: <5612A201.6030500@samsung.com>
References: <1442964843-11953-1-git-send-email-m.smarduch@samsung.com>
 <20151005154540.GJ9011@cbox> <5612A201.6030500@samsung.com>
Message-ID: <20151005172538.GK9011@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 09:14:57AM -0700, Mario Smarduch wrote:
> Hi Christoffer,
>    I just managed to boot qemu arm32 up on arm64 (last Fri - thanks for the tip
> - there were few other issue to clean up), so let me retest it again. Also I
> noticed some refactoring would help both 32 and 64 bit patches.
> 
> Yes I could provide a the user space tests as well.
> 
I'd like those regardless as I generally test my queue before pushing it
to next.

Thanks,
-Christoffer
