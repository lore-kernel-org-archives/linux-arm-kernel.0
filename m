From: will.deacon@arm.com (Will Deacon)
Date: Fri, 20 Jul 2012 11:17:51 +0100
Subject: [PATCH v2 2/2] ARM: delay: allow timer-based delay
 implementation to be selected
In-Reply-To: <50082598.5090706@arm.com>
References: <4FFEFDE3.5000403@codeaurora.org> <4FFF8509.2050302@renesas.com>
 <20120713085746.GA18079@mudshark.cambridge.arm.com>
 <CAMQu2gwPm_Y1as6dc4S-f9OEOZA32CCNKv_07MB+U7T4OS6qXg@mail.gmail.com>
 <20120713111337.GH18079@mudshark.cambridge.arm.com>
 <5004D78E.4050606@renesas.com>
 <CAMQu2gx9EU4GZ634RKiwD+sg0MoO-FAqc-pPU+HkryX8rXVBjA@mail.gmail.com>
 <5005176C.6050904@renesas.com>
 <20120718175233.GB16928@mudshark.cambridge.arm.com>
 <50082598.5090706@arm.com>
Message-ID: <20120720101751.GB26658@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2012 at 04:19:52PM +0100, Jonathan Austin wrote:
> We should probably also ignore and additional registration calls, not just
> those made after the delay loop has been calibrated...
> 
> Something like the patch below should do the trick.

[...]

Cheers, pushed into my delay branch. Note that I don't plan to queue these
patches until somebody decides they want a delay source other than the
architected timers in mainline.

Will
