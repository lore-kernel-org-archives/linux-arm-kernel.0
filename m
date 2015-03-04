From: will.deacon@arm.com (Will Deacon)
Date: Wed, 4 Mar 2015 15:25:05 +0000
Subject: [PATCH/RFC 0/4] Probe deferral for IOMMU DT integration
In-Reply-To: <1946782.v9knT4VCx7@avalon>
References: <1423182722-16646-1-git-send-email-lauraa@codeaurora.org>
 <1519819.qZaXvuQI61@avalon> <1946782.v9knT4VCx7@avalon>
Message-ID: <20150304152505.GE17250@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 03, 2015 at 11:54:46PM +0000, Laurent Pinchart wrote:
> Hello,

Hi Laurent,

> I haven't seen any reply to this e-mail. I know that the combination of IOMMU, 
> DMA mapping and DT doesn't exactly sound like fun, but I think we still need 
> to move on :-)

Yup, and thanks for taking the time to write this up!

> Will and Arnd, could you please confirm that my summary below matches your 
> memories of our discussion ?

It certainly matches my recollection, but I suspect the devil is in the
details and we'll have to have some discussions once somebody has a crack at
implementing this.

Will
