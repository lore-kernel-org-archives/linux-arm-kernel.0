From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 16 Nov 2016 19:03:37 +0200
Subject: [PATCH 0/8] DMA: s3c64xx: Conversion to the new channel request
 API
In-Reply-To: <20161116032620.GV3000@localhost>
References: <1478791076-19528-1-git-send-email-s.nawrocki@samsung.com>
 <20161116032620.GV3000@localhost>
Message-ID: <20161116170337.GA4124@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2016 at 08:56:20AM +0530, Vinod Koul wrote:
> On Thu, Nov 10, 2016 at 04:17:48PM +0100, Sylwester Nawrocki wrote:
> > This patch series aims to convert the s3c64xx platform to use
> > the new DMA channel request API, i.e. this is only meaningful 
> > for non-dt systems using s3c64xx SoCs.
> > 
> > Presumably the first 2 or 4 patches in this series could be queued 
> > for v4.10-rc1 and the remaining patches could be left for subsequent
> > release, to avoid non-trivial conflict with patches already applied 
> > in the ASoC tree.
> 
> I am fine with dma patch (expect the subsystem tag) and others except arm
> ones have acks, so I think we can merge this for v4.10-rc1. I cna create a
> immutable tag and people can merge into their tree in case they have
> dependencies.
> 
> Btw need acks on ARM patches before I can apply

First two ARM acked. Vinod, could you prepare a tag with them?

As I understood, everything won't be applied because ASoC tree already
contains some work around this?

Best regards,
Krzysztof
