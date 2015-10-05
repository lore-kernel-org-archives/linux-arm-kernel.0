From: m.smarduch@samsung.com (Mario Smarduch)
Date: Mon, 05 Oct 2015 18:23:38 +0000
Subject: [RFT - PATCH v2 0/2] KVM/arm64: add fp/simd lazy switch support
In-Reply-To: <20151005172538.GK9011@cbox>
References: <1442964843-11953-1-git-send-email-m.smarduch@samsung.com>
 <20151005154540.GJ9011@cbox> <5612A201.6030500@samsung.com>
 <20151005172538.GK9011@cbox>
Message-ID: <B9D0442AB76C74479F6F03D8FEE2938D835DE48B@sisaex01sj>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will do, I'll get them over to you.

-----Original Message-----
From: Christoffer Dall [mailto:christoffer.dall at linaro.org] 
Sent: Monday, October 05, 2015 10:26 AM
To: Mario Smarduch
Cc: kvmarm at lists.cs.columbia.edu; marc.zyngier at arm.com; kvm at vger.kernel.org; linux-arm-kernel at lists.infradead.org
Subject: Re: [RFT - PATCH v2 0/2] KVM/arm64: add fp/simd lazy switch support

On Mon, Oct 05, 2015 at 09:14:57AM -0700, Mario Smarduch wrote:
> Hi Christoffer,
>    I just managed to boot qemu arm32 up on arm64 (last Fri - thanks 
> for the tip
> - there were few other issue to clean up), so let me retest it again. 
> Also I noticed some refactoring would help both 32 and 64 bit patches.
> 
> Yes I could provide a the user space tests as well.
> 
I'd like those regardless as I generally test my queue before pushing it to next.

Thanks,
-Christoffer
