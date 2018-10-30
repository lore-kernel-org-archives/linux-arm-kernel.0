From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Oct 2018 12:59:52 +0000
Subject: [BUG] MVPP2 driver exploding in presence of a tap interface
In-Reply-To: <CAPv3WKfn6QFPnNjpY2dU5-OHftObzdcrHopX8Y9w5h37Zd4BNw@mail.gmail.com>
References: <6355174d-4ab6-595d-17db-311bce607aef@arm.com>
 <20181030105015.GB3407@kwain> <7bd72963-1e7c-5175-ba88-fc020d786f0c@arm.com>
 <CAPv3WKfn6QFPnNjpY2dU5-OHftObzdcrHopX8Y9w5h37Zd4BNw@mail.gmail.com>
Message-ID: <0899d630-782d-a60e-154e-e26c467aba72@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marcin,

On 30/10/18 12:37, Marcin Wojtas wrote:
> [Resend in UTF-8]
> 
> Hi Marc,
> 
> You use _really_ archaic firmware, the bug you see is 99% caused by a

Please let me fix this for you:

s/_really_ archaic/released/

> bug already fixed long time ago (cleanup all PP2 BM pools correctly
> during exit boot services). 

How long ago? Why didn't you say so when I reported the bug to you and
Antoine back in January? Also, why isn't that "clean-up" taken care of
by the Linux driver? Exiting boot services itself doesn't seem to cause
the issue, and it is setting the interface up that causes it.

> Please grab the latest release:
> https://github.com/MarvellEmbeddedProcessors/edk2-open-platform/wiki/files/flash-image-18.09.4.bin
> and let know if you observe any further issues with vanilla kernel.

What does this image contain?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
