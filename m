From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 7 Oct 2014 11:36:41 +0200
Subject: [PATCH v2 0/3] arm/arm64: KVM: Host 48-bit VA support and IPA
 limits
In-Reply-To: <20141007092455.GA12675@e104818-lin.cambridge.arm.com>
References: <1412627427-28629-1-git-send-email-christoffer.dall@linaro.org>
 <20141007092455.GA12675@e104818-lin.cambridge.arm.com>
Message-ID: <20141007093641.GD3717@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 07, 2014 at 10:24:58AM +0100, Catalin Marinas wrote:
> On Mon, Oct 06, 2014 at 09:30:24PM +0100, Christoffer Dall wrote:
> > The following host configurations have been tested with KVM on APM
> > Mustang:
> [...]
> >  3) 64KB  + 39 bits VA space
> 
> That would be 42-bit VA space.
> 
Yeah, -ECUTNPASTE, sorry about that.

-Christoffer
