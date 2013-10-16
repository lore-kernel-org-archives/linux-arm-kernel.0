From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 16 Oct 2013 07:35:16 +0530
Subject: [PATCH RESEND 0/3] ARM: S3C24XX: add missing dma-devices and
 warning fix
In-Reply-To: <525DC274.8090808@samsung.com>
References: <201310111059.19791.heiko@sntech.de>
 <20131013145642.GJ2954@intel.com>
 <201310132011.11285.heiko@sntech.de> <525DC274.8090808@samsung.com>
Message-ID: <20131016020516.GT2954@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 16, 2013 at 07:32:20AM +0900, Kukjin Kim wrote:
> On 10/14/13 03:11, Heiko St?bner wrote:
> >Am Sonntag, 13. Oktober 2013, 16:56:42 schrieb Vinod Koul:
> >>On Fri, Oct 11, 2013 at 10:59:19AM +0200, Heiko St?bner wrote:
> >>>[I messed up the linux-arm-kernel list address yesterday, so I resend it
> >>>with a fixed address, sorry for the noise]
> >>>
> >>>When Olof reported the warning about the unused s3c2410_dma_resource, I
> >>>thought the best way forward would be to simply implement the missing
> >>>pieces and so it has users :-) .
> >>>
> >>>Therefore this series adds the necessary platform-devices for s3c2410,
> >>>s3c2440 and s3c2442. This especially also includes the
> >>>channel-constraints of those socs.
> >>>
> >>>As I do not have access to any of those socs these changes are of course
> >>>compile-tested only.
> >>
> >>Do you want this to be applied thru dma or arm tree?
> >
> >hmm, the original series went into the samsung tree for 3.13, so maybe this
> >addition should go the same way?
> >
> I think so, let me pick this up into Samsung tree for v3.13.
Okay, sounds good. Ack for dmaengine patch sent

~Vinod
